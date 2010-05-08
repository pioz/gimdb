begin
  require 'gtk2'
rescue LoadError => e
  puts "Error: #{e.to_s}"
  puts ""
  puts "You must install 'gtk2' to run this program."
  puts "If you are using Debian/GNU Linux you can install it with:"
  puts ""
  puts "  apt-get install libgnome2-ruby"
  puts ""
  exit -1
end
begin
  require 'libglade2'
rescue LoadError => e
  puts "Error: #{e.to_s}"
  puts ""
  puts "You must install 'libglade2' to run this program."
  puts "If you are using Debian/GNU Linux you can install it with:"
  puts ""
  puts "  apt-get install libglade2-ruby"
  puts ""
  exit -1
end
require 'lib/imdb'
require 'src/controller'
require 'src/movie_box'


class GimdbGlade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = $DOMAIN, localedir = $LOCALEDIR, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, 'UTF-8')
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) { |handler| method(handler) }
    @searcher = IMDB.new
    @movies = []
    setting_up
  end
  

  private


  def setting_up
    # Get widgets from glade xml file
    @window            = @glade.get_widget('window')
    @sidebar           = @glade.get_widget('sidebar')
    @users_menu_item   = @glade.get_widget('users_menu_item')
    @entry_title       = @glade.get_widget('entry_title')
    @spin_year_from    = @glade.get_widget('spin_year_from')
    @spin_year_to      = @glade.get_widget('spin_year_to')
    @combo_rating_from = @glade.get_widget('combo_rating_from')
    @combo_rating_to   = @glade.get_widget('combo_rating_to')
    @b_search          = @glade.get_widget('b_search')
    @combo_sort        = @glade.get_widget('combo_sort')
    @toggle_sort       = @glade.get_widget('toggle_sort')
    @check_hide_seen   = @glade.get_widget('check_hide_seen')
    @check_only_see    = @glade.get_widget('check_only_see')
    @label_status      = @glade.get_widget('label_status')
    @progress          = @glade.get_widget('progress')
    @image_connection  = @glade.get_widget('image_connection')
    @image_spinner     = @glade.get_widget('image_spinner')
    @scrolled          = @glade.get_widget('scrolled')
    @vbox_movies       = Gtk::VBox.new
    @dialog_users      = @glade.get_widget('dialog_users')
    @entry_user        = @glade.get_widget('entry_user')
    @combo_del_users   = @glade.get_widget('combo_del_users')
    @table_combo       = @glade.get_widget('table_combo')
    @check_genres_all  =  @glade.get_widget('check_genres_all')

    @genres = [
     :action,:adventure,:animation,:biography,:comedy,
     :crime,:documentary,:drama,:family,:fantasy,:film_noir,
     :game_show,:history,:horror,:music,:musical,:mystery,:news,
     :romance,:sci_fi,:sport,:thriller,:war,:western
    ]
    @genres.each do |genre|
      instance_variable_set("@check_genres_#{genre}", @glade.get_widget("check_genres_#{genre}")).signal_connect('clicked') do
        @check_genres_all.active = false
      end
    end

    # Some stuffs
    @users = User.find(:all, :conditions => 'selected = 1')
    @all_users = User.all
    build_users_menu
    @spin_year_to.value = Time.now.year.to_i
    @combo_rating_from.active = 0
    @combo_rating_to.active = 9
    @combo_sort.active = 0
    @image_spinner.pixbuf_animation = Gdk::PixbufAnimation.new('data/icons/spinner16x16.gif')
    @scrolled.add_with_viewport(@vbox_movies)
    @scrolled.vscrollbar.signal_connect('value-changed') do |s|
      x = (s.adjustment.upper * 90.0)/100.0
      vadj = s.value + s.adjustment.page_size
      if (vadj > x && vadj > @vadj && @b_search.sensitive?)
        Thread.new{get_more_movies} if @b_search.sensitive?
        #get_more_movies if @b_search.sensitive?
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
    if rating_from != '1' && rating_to != '10'
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
    end
    options[:sort] = sort + (@toggle_sort.active? ? ',DESC' : '')
    return options
  end


  def searching(state)
    if state
      @b_search.sensitive = false
      update_progress_bar(0.0, 0.0, _('Searching'))
      @progress.show
      @label_status.show
      @image_spinner.show
    else
      @b_search.sensitive = true
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
    if @b_search.sensitive?
      clear_movies_list
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
  end

 
  def get_more_movies
    if @b_search.sensitive?
      searching(true)
      @movies += Controller::process_info(@searcher, :next => true, :offline => @offline) do |step, max, text|
        update_progress_bar(step, max, text)
      end
      update_movies_list
      searching(false)
    end
  end

  
  def clear_movies_list
    @scrolled.each { |child| @scrolled.remove(child) }
    @vbox_movies = Gtk::VBox.new
    @vbox_movies.border_width = 10
    @vbox_movies.spacing = 10    
    @scrolled.add_with_viewport(@vbox_movies)
    @scrolled.vscrollbar.adjustment.value = 0
  end


  def update_movies_list
    @progress.fraction = 0
    unless @index.nil?
      display_movies = @movies[@index..-1]
      display_movies.each_with_index do |m, i|
        if ((!@check_hide_seen.active? || (m.get_users(:seen) & @users).empty?) &&
            (!@check_only_see.active? || !(m.get_users(:to_see) & @users).empty?))
          @vbox_movies.pack_start(GtkGimdb::MovieBox.new(m, @users), false)
          @vbox_movies.pack_start(Gtk::HSeparator.new, false)
        end
        update_progress_bar(i, display_movies.size - 1, 'Building movie boxes')
      end
      @index = @movies.size
      @vbox_movies.show_all
    end
  end


  def build_users_menu
    submenu = Gtk::Menu.new
    @all_users.sort{|x,y| x.name <=> y.name}.each do |u|
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
    Thread.new{get_movies} if @b_search.sensitive?
    #get_movies if @b_search.sensitive?
  end

  def on_key_press(widget, arg = nil)
    on_search_clicked(widget) if arg.keyval == Gdk::Keyval::GDK_Return
  end

  def on_get_more_movies_clicked(widget, arg = nil)
    Thread.new{get_more_movies} if @b_search.sensitive?
    #get_more_movies if @b_search.sensitive?
  end

  def on_show_to_see_clicked(widget, arg = nil)
    Thread.new{get_movies(:to_see)}
  end

  def on_show_seen_clicked(widget, arg = nil)
    Thread.new{get_movies(:seen)}
  end

  def on_show_favourites_clicked(widget, arg = nil)
    Thread.new{get_movies(:favourites)}
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
    @combo_del_users = Gtk::ComboBox.new
    @table_combo.attach(@combo_del_users, 0,1, 1,2)
    @all_users.sort{|x,y| x.name <=> y.name}.each do |u|
      @combo_del_users.append_text(u.name)
    end
    @combo_del_users.active = 0
    @dialog_users.show_all
  end

  def on_add_users_clicked(widget, arg = nil)
    unless @entry_user.text.empty?
      u = User.new(:name => @entry_user.text)
      begin
        u.save
        @all_users << u
        build_users_menu
        @combo_del_users.append_text(u.name)
        @combo_del_users.active = 0
        @entry_user.text = ''
        @label_status.text = _('New user added')
        @label_status.show
        # @dialog_users.hide
      rescue
        nil
      end
    end
  end

  def on_del_users_clicked(widget, arg = nil)
    name = @combo_del_users.active_text
    u = User.find_by_name(name)
    unless u.nil? 
      u.destroy
      @all_users.delete(u)
      build_users_menu
      @combo_del_users.remove_text(@combo_del_users.active)
      @label_status.text = _('User deleted')
      @label_status.show
      # @combo_del_users.active = 0
    end
  end

  def on_select_all_users_clicked(widget, arg = nil)
    @users_menu_item.submenu.children.each do |c|
      c.active = !c.active?
    end
    @dialog_users.hide
  end

  def on_close_manage_users_clicked(widget, arg = nil)
    @dialog_users.hide
    @label_status.hide
  end

end
