class MainWindow < Qt::MainWindow
  attr_reader :ui, :movieboxes, :controller

  GENRES = [:all,:action,:adventure,:animation,:biography,:comedy,
            :crime,:documentary,:drama,:family,:fantasy,:film_noir,
            :game_show,:history,:horror,:music,:musical,:mystery,:news,
            :romance,:scifi,:sport,:thriller,:war,:western]
  SORTING = [tr('Movie meter'), tr('A-Z'), tr('Rating'), tr('Number of votes'), tr('Runtime'), tr('Year')]
  KINDS = [:to_see, :seen, :favourites]

  # Slots for UI
  slots 'on_menu_find_triggered()',
        'on_menu_next_triggered()',
        'on_menu_cancel_triggered()',
        'on_menu_edit_users_triggered()',
        *(KINDS.map{|k| "on_menu_#{k}_triggered()"}),
        'on_menu_offline_toggled(bool)',
        'on_menu_exit_triggered()',
        'on_menu_clear_triggered()',
        'on_button_find_clicked()',
        'on_button_cancel_clicked()',
        'scrollarea_changed(int)'

  # Slots for controller
  slots 'update_progress(int, int, const QString&)',
        'add_movies()'

  def initialize(parent = nil)
    super(parent)
    @ui = Ui_Main_window.new
    @ui.setupUi(self)
    @statusbar = Statusbar.new
    @ui.statusbar.addWidget(@statusbar)
    @movieboxes = []
    @movies_container = @ui.movies_container.clone
    @controller = Controller.new
    setup
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
    params[:genres] = GENRES[@ui.combo_genres.currentIndex]
    case @ui.combo_sort.currentIndex
    when 0; sort = 'moviemeter'
    when 1; sort = 'alpha'
    when 2; sort = 'user_rating'
    when 3; sort = 'num_votes'
    when 4; sort = 'runtime'
    when 5; sort = 'year'
    else; sort = 'moviemeter'
    end
    params[:sort] = sort + (@ui.check_sort_inv.checked? ? ',DESC' : '')
    params[:hide_seen] = @ui.check_hide_seen.checked?
    return params
  end

  def build_users_selection(users)
    @ui.menu_select_users.clear
    users.each do |u|
      action = UserAction.new(u, self)
      @ui.menu_select_users.addAction(action)
    end
  end

  private

  def make_connections_with_controller
    connect(@ui.scrollarea.verticalScrollBar, SIGNAL('valueChanged(int)'), self, SLOT('scrollarea_changed(int)'))
    connect(@controller, SIGNAL('update_progress(int, int, const QString&)'), self, SLOT('update_progress(int, int, const QString&)'), Qt::QueuedConnection)
    connect(@controller, SIGNAL('add_movies()'), self, SLOT('add_movies()'), Qt::QueuedConnection)
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
    # Combo genres
    GENRES.each { |gen| @ui.combo_genres.addItem(tr(gen.to_s.capitalize)) }
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
    # Add users in selection menu
    build_users_selection(@controller.users)
  end

  def searching(value)
    @searching = value
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
    @movieboxes.each do |child|
      @ui.movies_container.removeWidget(child)
      child.hide
    end
    @movieboxes.clear
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

  def add_movies
    @controller.movies.each_with_index do |movie, i|
      mb = Moviebox.new(movie)
      mb.build_users_control(@controller.users.select{|u| u.selected?})
      @ui.movies_container.addWidget(mb)
      @movieboxes << mb
    end
    @controller.get_posters(@movieboxes)
    update_progress(100, 100, tr('All done!'))
    searching(false)
  end

  # Slots for UI

  def on_menu_next_triggered
    searching(true)
    @controller.search_next(collect_params)
  end

  def on_menu_edit_users_triggered
    manager_dialog = ManagerDialog.new(@controller.users, self)
    manager_dialog.open
    manager_dialog.adjustSize
  end

  KINDS.each do |kind|
    define_method "on_menu_#{kind}_triggered" do
      searching(true)
      clear_movies
      @controller.send("local_search_#{kind}", collect_params)
    end
  end

  def on_menu_offline_toggled(value)
    if value
      self.windowTitle += ' (offline)'
      @statusbar.ui.image_offline.show
      @ui.combo_sort.enabled = false
      @ui.check_sort_inv.enabled = false
    else
      self.windowTitle = self.windowTitle.gsub(' (offline)', '')
      @statusbar.ui.image_offline.hide
      @ui.combo_sort.enabled = true
      @ui.check_sort_inv.enabled = true
    end
  end

  def on_menu_exit_triggered
    $qApp.quit
  end

  def on_menu_clear_triggered
    @ui.line_edit_search.clear
    @ui.spin_year_from.value = @ui.spin_year_from.minimum
    @ui.spin_year_to.value = Time.now.year
    @ui.combo_rating_min.currentIndex = 0
    @ui.combo_rating_max.currentIndex = 9
    @ui.combo_genres.currentIndex = 0
    @ui.combo_sort.currentIndex = 0
    @ui.check_sort_inv.checked = false
    @ui.check_hide_seen.checked = false
  end

  def on_button_find_clicked
    searching(true)
    clear_movies
    @controller.search(collect_params)
  end
  alias :on_menu_find_triggered :on_button_find_clicked

  def on_button_cancel_clicked
    @controller.cancel
    searching(false)
  end
  alias :on_menu_cancel_triggered :on_button_cancel_clicked

  def scrollarea_changed(value)
    max = @ui.scrollarea.verticalScrollBar.maximum
    if max > 0
      percent = 100 * value / max
      on_menu_next_triggered if percent > 80 && !@searching
    end
  end

end