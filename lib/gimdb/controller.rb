class Controller < Qt::Object
  attr_reader :movies, :users
  
  signals 'update_progress(int, int, const QString&)',
          'add_movies()'
  
  def initialize(parent = nil)
    super(parent)
    @searcher = IMDB.new
    @movies = []
    @users = User.scoped
  end
  
  def search(params)
    run_thread do
      if params[:offline]
        @movies = Movie.get_list(params)
      else
        res = @searcher.get_list(params) do |step, max, text, data|
          emit update_progress(step, max, tr('Downloading movies info') + '...')          
        end
        @movies = find_or_create_movies(res) do |step, max|
          emit update_progress(step, max, tr('Updating database') + '...')
        end
      end
      filter(params)
      emit add_movies
    end
  end
  
  def search_next(params)
    run_thread do
      if params[:offline]
        @movies = Movie.next
      else
        res = @searcher.next do |step, max|
          emit update_progress(step, max, tr('Downloading movies info') + '...')
        end
        @movies = find_or_create_movies(res) do |step, max|
          emit update_progress(step, max, tr('Updating database') + '...')
        end
      end
      filter(params)
      emit add_movies
    end    
  end  
  
  KINDS.each do |kind|
    define_method "local_search_#{kind}" do |params|
      run_thread do
        @movies = Movie.get_kind(@users, kind)
        filter(params)
        emit add_movies
      end
    end
  end
  
  def cancel
    stop_thread
  end
  
  def get_posters(movieboxes)
    Thread.new do
      movieboxes.each do |moviebox|
        if moviebox.movie.image_path.nil? || !File.exist?(moviebox.movie.image_path)
          image_path = "#{$APP_LOCAL_PATH}/posters/#{moviebox.movie.code}.jpg"
          if @searcher.get_image(moviebox.movie.image_url, image_path)
            moviebox.movie.image_path = image_path
            moviebox.movie.save!
            emit moviebox.set_poster(image_path)
          end
        end
      end      
    end
  end
  
  private
  
  def run_thread
    @searcher_backup = @searcher.clone
    @thread.kill if @thread
    @thread = Thread.new{yield}
    #yield
  end

  def stop_thread
    if @thread && @thread.alive?
      @thread.kill
      @searcher = @searcher_backup if @searcher_backup
    end
  end 
  
  def filter(params)
    if params[:hide_seen]
      @movies.select! do |movie|
        (movie.get_users(:seen) & @users).empty?
      end
    end
  end
  
  def find_or_create_movies(data)
    i = 1
    movies = []
    data.each do |k, v|
      movies << Movie.new(v)
      next
      record = Movie.find_by_code(v[:code])
      if record.nil?
        record = Movie.new(v)
        record.save!
      else
        if (Time.now - record.updated_at) > 1.day
          record.update_attributes(v.merge(:updated_at => Time.now))
        end
      end
      movies << record
      yield(i, data.size) if block_given?
      i += 1      
    end
    return movies
  end  
  
end