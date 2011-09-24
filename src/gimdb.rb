require 'rubygems'
require 'gtk2'

require "#{$GIMDB_PATH}/lib/imdb"
require "#{$GIMDB_PATH}/src/controller"
require "#{$GIMDB_PATH}/src/movie_box"
require "#{$GIMDB_PATH}/src/manager_box"


class GimdbGlade
  include GetText

  attr :glade

  def initialize(path_or_data, root = nil, domain = $DOMAIN, localedir = $LOCALEDIR)#, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, 'UTF-8')
    #@builder = GladeXML.new(path_or_data, root, domain, localedir, flag) { |handler| method(handler) }
    @builder = Gtk::Builder.new
    @builder << path_or_data
    @builder.translation_domain = domain
    @builder.connect_signals { |handler| method(handler) }
    @searcher = IMDB.new
    @movies = []
    setting_up
  end


  private


  def setting_up
    # Get widgets from glade xml file
    @window            = @builder['window']
    @sidebar           = @builder['sidebar']
    @users_menu_item   = @builder['users_menu_item']
    @entry_title       = @builder['entry_title']
    @spin_year_from    = @builder['spin_year_from']
    @spin_year_to      = @builder['spin_year_to']
    @combo_rating_from = @builder['combo_rating_from']
    @combo_rating_to   = @builder['combo_rating_to']
    @b_search          = @builder['b_search']
    @b_search.image = Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::BUTTON).show
    @b_cancel          = @builder['b_cancel']
    @combo_sort        = @builder['combo_sort']
    @toggle_sort       = @builder['toggle_sort']
    @check_hide_seen   = @builder['check_hide_seen']
    @check_only_see    = @builder['check_only_see']
    @label_status      = @builder['label_status']
    @progress          = @builder['progress']
    @image_connection  = @builder['image_connection']
    @image_spinner     = @builder['image_spinner']
    @scrolled          = @builder['scrolled']
    @vbox_movies       = Gtk::VBox.new
    @dialog_users      = @builder['dialog_users']
    @dialog_users_box  = @builder['dialog_users_box'].pack_start(GtkGimdb::ManagerBox.new(:users, :name) do |t|
                                                                            @label_status.text = _(t)
                                                                            @label_status.show
                                                                            build_users_menu
                                                                          end)
    @check_genres_all  = @builder['check_genres_all']

    @genres = [
     :action,:adventure,:animation,:biography,:comedy,
     :crime,:documentary,:drama,:family,:fantasy,:film_noir,
     :game_show,:history,:horror,:music,:musical,:mystery,:news,
     :romance,:sci_fi,:sport,:thriller,:war,:western
    ]
    @genres.each do |genre|
      instance_variable_set("@check_genres_#{genre}", @builder["check_genres_#{genre}"]).signal_connect('clicked') do
        @check_genres_all.active = false
      end
    end

    # Some stuffs
    @users = User.find(:all, :conditions => 'selected = 1')
    build_users_menu
    @spin_year_from.adjustment = Gtk::Adjustment.new(0, 1978, Time.now.year.to_i + 10, 1, 1, 0) 
    @spin_year_from.value = 1978
    @spin_year_to.adjustment = Gtk::Adjustment.new(0, 1978, Time.now.year.to_i + 10, 1, 1, 0) 
    @spin_year_to.value = Time.now.year.to_i
    model = Gtk::ListStore.new(String)
    renderer = Gtk::CellRendererText.new
    (1..10).each do |val|
      iter = model.append
      iter[0] = val.to_s
    end
    @combo_rating_from.model = model
    @combo_rating_from.pack_start(renderer, true)
    @combo_rating_from.set_attributes(renderer, :text => 0)
    @combo_rating_from.active = 0
    @combo_rating_to.model = model
    @combo_rating_to.pack_start(renderer, true)
    @combo_rating_to.set_attributes(renderer, :text => 0)
    @combo_rating_to.active = 9
    model = Gtk::ListStore.new(String)
    [_('Movie meter'), _('A-Z'), _('Rating'), _('Number of votes'), _('Runtime'), _('Year')].each do |val|
      iter = model.append
      iter[0] = val
    end
    @combo_sort.model = model
    @combo_sort.pack_start(renderer, true)
    @combo_sort.set_attributes(renderer, :text => 0)
    @combo_sort.active = 0

    @image_spinner.pixbuf_animation = Gdk::PixbufAnimation.new("#{$GIMDB_PATH}/data/icons/spinner16x16.gif")
    @scrolled.add_with_viewport(@vbox_movies)
    @scrolled.vscrollbar.signal_connect('value-changed') do |s|
      x = (s.adjustment.upper * 90.0)/100.0
      vadj = s.value + s.adjustment.page_size
      if (vadj > x && vadj > @vadj)
        run_thread{get_more_movies} if @thread.nil? || !@thread.alive?
      end
      @vadj = vadj
    end
    @vbox_movies.border_width = 10
    @vbox_movies.spacing = 10

    # Window startup
    @window.signal_connect('delete_event') { Gtk.main_quit }
    @window.show_all
    @progress.hide
    @label_status.hide
    @image_spinner.hide
    @image_connection.hide
  end


  def build_options
    options = {}
    options[:offline]      = @offline
    options[:title]        = @entry_title.text unless @entry_title.text.blank?
    options[:release_date] = "#{@spin_year_from.value.to_i},#{@spin_year_to.value.to_i}"
    rating_from = @combo_rating_from.active_text
    rating_to = @combo_rating_to.active_text
    if rating_from != '1' || rating_to != '10'
      options[:user_rating]  = "#{rating_from},#{rating_to}"
    end
    unless @check_genres_all.active?
      options[:genres] = ''
      @genres.each do |genre|
        options[:genres] += "#{genre}," if instance_variable_get("@check_genres_#{genre}").active?
      end
      options[:genres].chop!
    end
    case @combo_sort.active
    when 0
      sort = 'moviemeter'
    when 1
      sort = 'alpha'
    when 2
      sort = 'user_rating'
    when 3
      sort = 'num_votes'
    when 4
      sort = 'runtime'
    when 5
      sort = 'year'
    else
      sort = 'moviemeter'
    end
    options[:sort] = sort + (@toggle_sort.active? ? ',DESC' : '')
    return options
  end


  def run_thread
    @searcher_backup = @searcher.clone
    @thread.kill if @thread
    @thread = Thread.new{yield}
  end


  def stop_thread
    if @thread && @thread.alive?
      @thread.kill
      @searcher = @searcher_backup if @searcher_backup
    end
    searching(false)
  end


  def searching(state)
    if state
      update_progress_bar(0.0, 0.0, _('Searching'))
      @b_cancel.sensitive = true
      @progress.show
      @label_status.show
      @image_spinner.show
    else
      @b_cancel.sensitive = false
      @progress.hide
      @label_status.hide
      @image_spinner.hide
    end
  end


  def update_progress_bar(step, max, text = nil)
    max = 80000 if max.nil? || max == 0
    fraction = step.to_f / max.to_f
    fraction = 1.0 if fraction > 1.0
    @progress.fraction = fraction
    @label_status.text = _(text) + '...' unless text.nil?
  end


  def get_movies(kind = nil)
    searching(true)
    if kind.nil?
      @movies = Controller::process_info(@searcher, build_options) do |step, max, text|
        update_progress_bar(step, max, text)
      end
    else
      @movies = Movie.get_kind(@users, kind)
    end
    @index = 0
    update_movies_list
    searching(false)
  end


  def get_more_movies
    searching(true)
    @movies += Controller::process_info(@searcher, :next => true, :offline => @offline) do |step, max, text|
      update_progress_bar(step, max, text)
    end
    update_movies_list
    searching(false)
  end


  def clear_movies_list
    @scrolled.each { |child| @scrolled.remove(child) }
    @vbox_movies = Gtk::VBox.new
    @vbox_movies.border_width = 10
    @vbox_movies.spacing = 10
    @scrolled.add_with_viewport(@vbox_movies)
    @scrolled.vscrollbar.adjustment.value = 0
    @vbox_movies.show_all
  end


  def update_movies_list
    @progress.fraction = 0
    @index ||= 0
    clear_movies_list if @index == 0
    display_movies = @movies[@index..-1]
    b = GtkGimdb::MovieBox.new(display_movies.first, @users)
    display_movies.each_with_index do |m, i|
      if ((!@check_hide_seen.active? || (m.get_users(:seen) & @users).empty?) &&
          (!@check_only_see.active? || !(m.get_users(:to_see) & @users).empty?))
        @vbox_movies.pack_start(GtkGimdb::MovieBox.new(m, @users), false)
        @vbox_movies.pack_start(Gtk::HSeparator.new, false)
        #@vbox_movies.realize
      end
      update_progress_bar(i, display_movies.size - 1, 'Building movie boxes')
    end
    @index = @movies.size
    #clear_movies_list if @index == 0
    @vbox_movies.show_all
  end


  def build_users_menu
    @users = User.find(:all, :conditions => 'selected = 1')
    submenu = Gtk::Menu.new
    User.all.sort{|x,y| x.name <=> y.name}.each do |u|
      m = Gtk::CheckMenuItem.new(u.name)
      m.active = true if @users.include?(u)
      submenu.append(m)
      m.signal_connect('toggled') do
        if m.active?
          u.selected = 1
          u.save!
          @users << u
        else
          u.selected = 0
          u.save!
          @users.delete(u)
        end
        @users.sort!{|x,y| x.name <=> y.name}
      end
    end
    @users_menu_item.submenu = submenu
    @users_menu_item.show_all
  end


   ############
  ### Events ###
   ############


  def on_search_clicked(widget, arg = nil)
    run_thread{get_movies}
    #get_movies
  end

  def on_key_press(widget, arg = nil)
    on_search_clicked(widget) if arg.keyval == Gdk::Keyval::GDK_Return
  end

  def on_get_more_movies_clicked(widget, arg = nil)
    run_thread{get_more_movies}
  end

  def on_show_to_see_clicked(widget, arg = nil)
    run_thread{get_movies(:to_see)}
  end

  def on_show_seen_clicked(widget, arg = nil)
    run_thread{get_movies(:seen)}
  end

  def on_show_favourites_clicked(widget, arg = nil)
    run_thread{get_movies(:favourites)}
  end

  def on_cancel_clicked(widget, arg = nil)
    stop_thread
  end

  def on_clean_clicked(widget, arg = nil)
    @entry_title.text = ''
    @spin_year_from.value = 1970
    @spin_year_to.value = Time.now.year.to_i
    @combo_rating_from.active = 0
    @combo_rating_to.active = 9
    @combo_sort.active = 0
    @genres.each do |genre|
      instance_variable_get("@check_genres_#{genre}").active = false
      @check_genres_all.active = true
    end
  end

  def on_work_offline_clicked(widget, arg = nil)
    @offline = !widget.active?
    if @offline
      @window.title += ' (offline)'
      @image_connection.show
    else
      @window.title = @window.title.gsub(' (offline)', '')
      @image_connection.hide
    end
  end

  def on_quit_clicked(widget, arg = nil)
    Gtk.main_quit
  end

  def on_show_sidebar(widget, arg = nil)
    widget.active? ? @sidebar.show : @sidebar.hide
  end

  def on_manage_users_clicked(widget, arg = nil)
    @dialog_users.show_all
  end

  def on_select_all_users_clicked(widget, arg = nil)
    @users_menu_item.submenu.children.each do |c|
      c.active = !c.active?
    end
    @dialog_users.hide
    @label_status.hide
  end

  def on_close_manage_users_clicked(widget, arg = nil)
    @dialog_users.hide
    @label_status.hide
  end

  def on_about_clicked(widget, arg = nil)
    @dialog_about = Gtk::AboutDialog.new
    begin
      f = File.open("#{$GIMDB_PATH}/VERSION", 'r')
      version = ''
      f.each_line { |line| version += line }
      @dialog_about.version = version
    rescue
      nil
    end
    begin
      f = File.open("#{$GIMDB_PATH}/LICENSE", 'r')
      license = ''
      f.each_line { |line| license += line }
      @dialog_about.license = license
    rescue
      nil
    end
    @dialog_about.program_name = 'GIMDB'
    @dialog_about.logo = Gdk::Pixbuf.new("#{$GIMDB_PATH}/data/icons/imdb.png")
    @dialog_about.comments = 'GTK graphical interface for the Internet Movie DataBase.'
    @dialog_about.copyright = "Copyright (c) #{Time.now.year} Enrico Pilotto"
    @dialog_about.website = 'http://github.com/pioz/gimdb'
    @dialog_about.website_label = 'Website'
    @dialog_about.authors = ['Enrico Pilotto <enrico@megiston.it>']
    @dialog_about.translator_credits = 'Italian: Enrico Pilotto <enrico@megiston.it>'
    @dialog_about.modal = true
    @dialog_about.skip_taskbar_hint = true
    @dialog_about.signal_connect('response') { @dialog_about.hide }
    @dialog_about.run
  end

end

