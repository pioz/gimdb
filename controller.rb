require 'lib/imdb'
require 'model'


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
        res = imdb.get_list(options)
      else
        res = imdb.next
      end
      res.sort{|x,y| x[0] <=> y[0]}.each do |k,v|
        record = Movie.find(:first, :conditions => "code = '#{v[:code]}'")
        if record.nil?
          record = Movie.new(v)
          options[:path] ||= "#{$GIMDB_PATH}/posters/"
          image_path = "#{options[:path]}#{record.code}.jpg"
          if imdb.get_image(record.image_url, image_path)
            record.image_path = image_path
          end
          record.save!
        elsif (Time.now - record.updated_at) > 1.day
          record.update_attributes(v.merge(:updated_at => Time.now))
          record.save!
        end
        movies << record
      end
      return movies
    end
  end

end
