require "#{$APP_PATH}/lib/gimdb/ui/ui_moviebox"

class MovieCheckBox < Qt::CheckBox
  
  slots 'set_user(bool)'
  
  def initialize(movie, user, kind, parent = nil)
    super(parent)
    @movie = movie
    @user = user
    @kind = kind
    self.checked = @movie.get_users(@kind).include?(@user)
    case @kind
    when :to_see; self.text = tr('to see')
    when :seen; self.text = tr('seen')
    when :favourites; self.text = tr('favourite')
    end
    self.styleSheet = 'QCheckBox { font-size: 8pt; font-style: italic; }'
    connect(self, SIGNAL('toggled(bool)'), self, SLOT('set_user(bool)'))
  end
  
  private
  
  def set_user(value)
    if value
      @movie.set_user(@user, @kind)
    else
      @movie.remove_user(@user, @kind)
    end
  end
  
end

class Moviebox < Qt::Widget
  attr_reader :ui, :movie

  slots 'image=(const QString&)'
  signals 'set_poster(const QString&)'

  def initialize(movie, parent = nil)
    super(parent)
    @movie = movie
    @ui = Ui_Moviebox.new
    @ui.setupUi(self)
    connect(self, SIGNAL('set_poster(const QString&)'), self, SLOT('image=(const QString&)'))
    display_movie
    #@ui.poster.styleSheet = "QLabel { border: 2px outset gray; border-radius: 20px; background-image: url(:/icons/no_poster.png); }"
  end

  def image=(url)    
    url = ':/icons/no_poster.png' unless File.exist?(url)
    @ui.poster.styleSheet = @ui.poster.styleSheet.gsub(/url\(.*?\)/, "url(#{url})")  
  end  

  def add_users_control(users)
    @ui.users_box.horizontalSpacing = 10
    users.each_with_index do |user, i|
      @ui.users_box.addWidget(Qt::Label.new(user.name), i, 0)
      checks = []
      [:to_see, :seen, :favourites].each_with_index do |kind, j|
        checks << MovieCheckBox.new(@movie, user, kind)  
        checks[j].text = '' if i > 0
        @ui.users_box.addWidget(checks[j], i, j+1)
      end
    end
  end
  
  private
  
  def display_movie
    # Only to not set blank strings in .ui xml file
    # Put '' now
    @ui.instance_variables.each do |v|
      v = @ui.instance_variable_get(v)
      v.text = '' if v.class == Qt::Label
    end
    
    @ui.title.text = @movie.title
    @ui.title.toolTip = @movie.code
    @ui.year.text = "(#{@movie.year})" if @movie.year
    if @movie.rating
      @ui.rating.text = "#{@movie.rating}/10"
      @ui.rating.toolTip = @movie.votes.to_s + ' ' + tr('votes') if @movie.votes
    end
    @ui.outline.text = @movie.outline if @movie.outline
    @ui.credit.text = @movie.credit if @movie.credit
    @ui.genres.text = @movie.genre.gsub('|', ' | ') if @movie.genre
    if @movie.runtime
      @ui.runtime.text = @movie.runtime.to_i.to_s + ' ' + tr('mins')
      if @movie.runtime
        time = Time.now.midnight + @movie.runtime * 60
        @ui.runtime.toolTip = "#{time.hour}:#{"%02d" % time.min}"
      end
    end
    self.image = @movie.image_path if @movie.image_path
  end

end