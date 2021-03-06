require "#{$APP_PATH}/lib/imdb"
require "#{$APP_PATH}/lib/gimdb/model"


module Controller

  def self.process_info(imdb, options = {})
    if options[:offline]
      unless options[:next]
        return Movie.get_list(options)
      else
        return Movie.next
      end
    else
      movies = []
      unless options[:next]
        res = imdb.get_list(options) { |step, max| yield(step, max, t('Downloading movies info')) if block_given? }
      else
        res = imdb.next { |step, max| yield(step, max, t('Downloading movies info')) if block_given? }
      end
      i = 0
      res.sort{|x,y| x[0] <=> y[0]}.each do |k,v|
        if block_given?
          yield(i, res.size, t('Updating database'))
          i += 1
        end
        record = Movie.find(:first, :conditions => "code = '#{v[:code]}'")
        if record.nil?
          record = Movie.new(v)
          record.save!
        else
          if (Time.now - record.updated_at) > 1.day
            record.update_attributes(v.merge(:updated_at => Time.now))
            record.save!
          end
        end
        movies << record
      end
      yield(res.size, res.size) if block_given?
      return movies
    end
  end
  
  def self.get_poster(imdb, record, options = {})
    options[:path] ||= "#{$APP_LOCAL_PATH}/posters/"
    image_path = "#{options[:path]}#{record.code}.jpg"
    if imdb.get_image(record.image_url, image_path)
      record.image_path = image_path
      record.save!
    end
  end

end