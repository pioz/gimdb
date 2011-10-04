require "#{$APP_PATH}/lib/gimdb/ui/ui_statusbar.rb"

class Statusbar < Qt::Widget
  attr_reader :ui

  def initialize(parent = nil)
    super(parent)
    @ui = Ui_Statusbar.new
    @ui.setupUi(self)

    @ui.progressbar.hide
    @ui.image_offline.hide
    @ui.image_spinner.hide

    @movie = Qt::Movie.new
    @movie.cacheMode = Qt::Movie::CacheAll
    @movie.fileName = ':/icons/spinner16x16.gif'
    @ui.image_spinner.movie = @movie
    @ui.image_spinner.movie.start
  end
  
  def text
    @ui.status_text.text
  end
  
  def text=(s)
    @ui.status_text.text = s
  end

end