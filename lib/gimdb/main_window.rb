require "#{$APP_PATH}/lib/gimdb/ui/ui_main_window"
require "#{$APP_PATH}/lib/gimdb/statusbar"
require "#{$APP_PATH}/lib/gimdb/controller"

class MainWindow < Qt::MainWindow
  attr_reader :ui

  GENRES = [:action,:adventure,:animation,:biography,:comedy,
            :crime,:documentary,:drama,:family,:fantasy,:film_noir,
            :game_show,:history,:horror,:music,:musical,:mystery,:news,
            :romance,:scifi,:sport,:thriller,:war,:western]
  SORTING = [tr('Movie meter'), tr('A-Z'), tr('Rating'), tr('Number of votes'), tr('Runtime'), tr('Year')]
  KINDS = [:to_see, :seen, :favourites]
  # Slots for UI
  slots 'on_menu_find_triggered()',
        'on_menu_next_triggered()',
        'on_menu_cancel_triggered()',
        *(KINDS.map{|k| "on_menu_#{k}_triggered()"}),
        'on_menu_offline_toggled(bool)',
        'on_menu_exit_triggered()',
        'on_check_genres_all_toggled(bool)',
        *(GENRES.map{|g| "on_check_genres_#{g}_toggled(bool)"}),
        'on_button_clear_clicked()',
        'on_button_find_clicked()',
        'on_button_cancel_clicked()'

  # Slots for controller
  slots 'update_progress(int, int, const QString&)',
        'add_movies(bool)'

  def initialize(parent = nil)
    super(parent)
    @ui = Ui_Main_window.new
    @ui.setupUi(self)
    @statusbar = Statusbar.new
    @ui.statusbar.addWidget(@statusbar)
    setup
    @controller = Controller.new
    make_connections_with_controller
	end
  
  def collect_params
    params = {}
    params[:offline] = @ui.menu_offline.checked?
    params[:title] = @ui.line_edit_search.text if @ui.line_edit_search.text != ''
    params[:release_date] = "#{@ui.spin_year_from.value.to_i},#{@ui.spin_year_to.value.to_i}"
    rating_from = @ui.combo_rating_min.currentIndex + 1
    rating_to = @ui.combo_rating_max.currentIndex + 1    
    params[:user_rating]  = "#{rating_from},#{rating_to}" if rating_from != 1 || rating_to != 10    
    unless @ui.check_genres_all.checked?
      params[:genres] = GENRES.select { |g| @ui.send("check_genres_#{g}").checked? }.join(',')
    end
    case @ui.combo_sort.currentIndex
    when 0; sort = 'moviemeter'
    when 1; sort = 'alpha'
    when 2; sort = 'user_rating'
    when 3; sort = 'num_votes'
    when 4; sort = 'runtime'
    when 5; sort = 'year'
    else; sort = 'moviemeter'
    end
    params[:sort] = sort + (@ui.button_sort_inv.checked? ? ',DESC' : '')
    params[:hide_seen] = @ui.check_hide_seen.checked?
    return params
  end  
  
  private
  
  def make_connections_with_controller
    connect(@controller, SIGNAL('update_progress(int, int, const QString&)'), self, SLOT('update_progress(int, int, const QString&)'), Qt::QueuedConnection) 
    connect(@controller, SIGNAL('add_movies(bool)'), self, SLOT('add_movies(bool)'), Qt::QueuedConnection) 
  end
  
  def setup
    # Spin year
    @ui.spin_year_to.value = Time.now.year
    @ui.spin_year_to.maximum = Time.now.year + 10
    # Combo rating
    (1..10).each do |r|
      @ui.combo_rating_min.addItem(r.to_s)
      @ui.combo_rating_max.addItem(r.to_s)
    end
    @ui.combo_rating_max.currentIndex = 9
    # Combo sort
    SORTING.each { |sort| @ui.combo_sort.addItem(sort) }    
    # Button find focused
    @ui.button_find.setFocus
    # Button cancel disabled
    @ui.button_cancel.enabled = false
    @ui.menu_cancel.enabled = false
    # Center main window to screen
    geo = Qt::DesktopWidget.new.availableGeometry
    x = (geo.width / 2.0) - (rect.width / 2.0)
    y = (geo.height / 2.0) - (rect.height / 2.0)
    move(x, y)
  end  
  
  def searching(value)
    @ui.button_find.enabled = !value
    @ui.menu_find.enabled = !value
    @ui.menu_next.enabled = !value
    @ui.button_cancel.enabled = value
    @ui.menu_cancel.enabled = value
    @statusbar.ui.progressbar.visible = value
    @statusbar.ui.progressbar.value = 0
    @statusbar.ui.progressbar.maximum = 100
    @statusbar.ui.image_spinner.visible = value
    @statusbar.text = value ? tr('Searching') + '...' : ''    
  end  
  
  def clear_movies
    # TODO
    puts 'CLEAR MOVIES LIST'
  end
  
  #########
  # SLOTS #
  #########  
  
  # Slots for controller
  
  def update_progress(step, max, text)
    @statusbar.ui.progressbar.value = step
    @statusbar.ui.progressbar.maximum = max
    @statusbar.text = text
  end
  
  def add_movies(clear_list) 
    movies = @controller.movies
    clear_movies if clear_list
    # TODO
    puts movies.map(&:title).inspect
    update_progress(100, 100, tr('All done!'))
    searching(false)
  end  
  
  # Slots for UI
  
  def on_menu_find_triggered
    on_button_find_clicked
  end
  
  def on_menu_next_triggered
    searching(true)
    @controller.search_next(collect_params)
  end
  
  def on_menu_cancel_triggered
    on_button_cancel_clicled
  end
  
  KINDS.each do |kind|
    define_method "on_menu_#{kind}_triggered" do
      searching(true)
      @controller.send("local_search_#{kind}", collect_params)
    end
  end
  
  def on_menu_offline_toggled(value)
    if value
      self.windowTitle += ' (offline)'
      @statusbar.ui.image_offline.show
      @ui.combo_sort.enabled = false
      @ui.button_sort_inv.enabled = false
    else
      self.windowTitle = self.windowTitle.gsub(' (offline)', '')
      @statusbar.ui.image_offline.hide
      @ui.combo_sort.enabled = true
      @ui.button_sort_inv.enabled = true
    end
  end
  
  def on_menu_exit_triggered
    $qApp.quit
  end
  
  def on_check_genres_all_toggled(value)
    GENRES.each { |g| @ui.send("check_genres_#{g}").checked = false } if value    
  end
  
  GENRES.each do |g|
    define_method "on_check_genres_#{g}_toggled" do |value|
      @ui.check_genres_all.checked = false if value
    end
  end
  
  def on_button_clear_clicked
    @ui.line_edit_search.clear
    @ui.spin_year_from.value = @ui.spin_year_from.minimum
    @ui.spin_year_to.value = Time.now.year
    @ui.combo_rating_min.currentIndex = 0
    @ui.combo_rating_max.currentIndex = 9
    @ui.combo_sort.currentIndex = 0
    @ui.button_sort_inv.checked = false
    @ui.check_hide_seen.checked = false
    @ui.check_genres_all.checked = false
    GENRES.each { |g| @ui.send("check_genres_#{g}").checked = false }    
  end
  
  def on_button_find_clicked
    searching(true)
    @controller.search(collect_params)
  end
    
  def on_button_cancel_clicked
    @controller.cancel
    searching(false)
  end
  
end