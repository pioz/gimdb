require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'


class IMDB

  @@URL      = 'http://www.imdb.com/search/title/'
  @@BASE_URL = 'www.imdb.com'
  @@PATH_URL = '/search/title/'


  module StringStripper
    def stripper
      self.strip.squeeze(' ').gsub(/[\302\240]+/,'').gsub('&', '&amp;')
    end
  end
  String.send(:include, StringStripper)


  def get_list(options = {})
    @start = options[:start] || 1
    set_request(options)
    return perform_list_search { |step, max, text| yield(step, max, text) if block_given? }
  end


  def next
    return {} if @params.nil?
    @start = @start + 50
    return perform_list_search { |step, max, text| yield(step, max, text) if block_given? }
  end


  def get_image(url, path, x = 160)
    # http://ia.media-imdb.com/images/*.jpg
    if url.match(/^http:\/\/ia\.media-imdb\.com\/images\/.*\.jpg/)
      base  = url.split('._V1._')[0]
      style = "._V1._SX#{160}_.jpg"
      final = base + style
      begin
        File.open(path, 'w') do |f|
          open(final) { |stream| f << stream.read }
        end
        return true
      rescue
        File.delete(path)
        puts "Error to save image at '#{final}'"
        return false
      end
    end
    return false
  end


  private


  def set_request(options = {})
    @params  = '?title_type=feature'
    @params += "&title=#{options[:title].gsub(' ','%20')}" if options[:title]
    @params += "&release_date=#{options[:release_date]}"   if options[:release_date]
    @params += "&user_rating=#{options[:user_rating]}"     if options[:user_rating]
    @params += "&num_votes=#{options[:num_votes]}"         if options[:num_votes]
    @params += "&genres=#{options[:genres]}"               if options[:genres]
    @params += "&my_ratings=#{options[:my_ratings]}"       if options[:my_ratings]
    @params += "&sort=#{options[:sort]}"                   if options[:sort]
    return @params
  end


  def perform_list_search
    list = {}
    doc = Nokogiri::HTML(open(@@URL + @params + "&start=#{@start}",
                              :content_length_proc => lambda do |t|
                                if block_given?
                                  @max = t
                                  yield(0, @max, 'Downloading movies info')
                                end
                              end,
                              :progress_proc => lambda do |s|
                                yield(s, @max) if block_given?
                              end))
    yield(@max, @max) if block_given?
    doc.css('table.results tr.detailed').each do |movie|
      info = {}
      number           = movie.css('td.number').first.content.stripper.to_i
      info[:code]      = movie.css('td.title > a').first[:href].split('/')[2]                        rescue nil
      info[:title]     = movie.css('td.title > a').first.content.stripper                            rescue nil
      info[:image_url] = movie.css('td.image img').first[:src].stripper                              rescue nil
      info[:year]      = movie.css('td.title > span.year_type').first.content.stripper[1..-2]        rescue nil
      info[:votes]     = movie.css('td.title > div.user_rating').first[:title].stripper.gsub(',','') rescue nil
      info[:rating]    = movie.css('td.title > div.user_rating').first.content.stripper              rescue nil
      info[:outline]   = movie.css('td.title > span.outline').first.content.stripper                 rescue nil
      info[:credit]    = movie.css('td.title > span.credit').first.content.stripper                  rescue nil
      info[:genre]     = movie.css('td.title > span.genre').first.content.stripper                   rescue nil
      info[:runtime]   = movie.css('td.title > span.runtime').first.content.stripper                 rescue nil
      list[number] = info
    end
    return list
  end

end
