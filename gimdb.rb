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
require 'controller.rb'
require 'imdb.rb'
require 'movie_box.rb'


class GimdbGlade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
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
    @check_hide_seen   = @glade.get_widget('check_hide_seen')
    @check_only_see    = @glade.get_widget('check_only_see')
    @spinner           = @glade.get_widget('spinner')
    @spinner_space     = @glade.get_widget('spinner_space')
    @statusbar         = @glade.get_widget('statusbar')
    @scrolled          = @glade.get_widget('scrolled')
    @vbox_movies       = Gtk::VBox.new
    @dialog_users      = @glade.get_widget('dialog_users')
    @entry_user        = @glade.get_widget('entry_user')
    @combo_del_users   = @glade.get_widget('combo_del_users')
    @table_combo       = @glade.get_widget('table_combo')
    
    # Some stuffs
    @users = User.find(:all, :conditions => 'selected = 1')
    @all_users = User.all
    build_users_menu
    @spin_year_to.value = Time.now.year.to_i
    @combo_rating_from.active = 0
    @combo_rating_to.active = 9
    @statusbar.push(0, '')
    @spinner.pixbuf_animation = Gdk::PixbufAnimation.new('icons/spinner32x32.gif')
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
    @spinner.hide
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
    #options[:sort]         = 
    return options
  end


  def searching(state)
    if state
      @spinner.show
      @spinner_space.hide
      @b_search.sensitive = false
    else
      @spinner.hide
      @spinner_space.show
      @b_search.sensitive = true
    end
  end


  def get_movies(kind = nil)
    if @b_search.sensitive?
      searching(true)
      if kind.nil?
        @movies = Controller::process_info(@searcher, build_options)
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
      @movies += Controller::process_info(@searcher, :next => true, :offline => @offline)
      update_movies_list
      searching(false)
    end
  end


  def update_movies_list
    unless @index.nil?
      if @index == 0
        @vbox_movies.each do |child|
          @vbox_movies.remove(child)
        end
        @scrolled.vscrollbar.adjustment.value = 0
      end
      @movies[@index..-1].each do |m|
        if ((!@check_hide_seen.active? || (m.get_users(:seen) & @users).empty?) &&
            (!@check_only_see.active? || !(m.get_users(:to_see) & @users).empty?))
          @vbox_movies.pack_start(GtkGimdb::MovieBox.new(m, @users), false)
          @vbox_movies.pack_start(Gtk::HSeparator.new, false)
        end
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

  
  # Events
  def on_search_clicked(widget, arg = nil)
    Thread.new{get_movies} if @b_search.sensitive?
    #get_movies if @b_search.sensitive?
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
  end

  def on_work_offline_clicked(widget, arg = nil)
    @offline = !widget.active?
    if @offline
      @window.title += ' (offline)'
    else
      @window.title = @window.title.gsub(' (offline)', '')
    end
  end

  def on_quit_clicked(widget, arg = nil)
    Gtk.main_quit
  end

  def on_show_sidebar(widget, arg = nil)
    widget.active? ? @sidebar.show : @sidebar.hide
  end

  def on_key_press(widget, arg = nil)
    on_search_clicked(widget) if arg.keyval == Gdk::Keyval::GDK_Return
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
        #@dialog_users.hide
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
      #@combo_del_users.active = 0
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
  end

end
