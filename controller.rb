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
        res = imdb.get_list(options) { |step, max, text| yield(step, max, text) if block_given? }
      else
        res = imdb.next { |step, max, text| yield(step, max, text) if block_given? }
      end
      i = 0
      res.sort{|x,y| x[0] <=> y[0]}.each do |k,v|
        if block_given?
          yield(i, res.size, 'Downloading movie posters')
          i = i + 1
        end
        record = Movie.find(:first, :conditions => "code = '#{v[:code]}'")
        if record.nil?
          record = Movie.new(v)
          options[:path] ||= "#{$GIMDB_PATH}/posters/"
          image_path = "#{options[:path]}#{record.code}.jpg"
          if imdb.get_image(record.image_url, image_path)
            record.image_path = image_path
          end
          record.save!
        else
          imdb.get_image(record.image_url, record.image_path) if !record.image_path.nil? && !File.exists?(record.image_path)
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

end
