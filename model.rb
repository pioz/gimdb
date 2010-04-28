require 'rubygems'
require 'active_record'


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db.sqlite3"
)


class Popular < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
end


class Movie < ActiveRecord::Base
  has_many :populars, :dependent => :delete_all
  has_many :users, :through => :populars

  def get_users(what = :to_see)
    code = Movie.get_code(what)
    unless code.nil?
      pops = Popular.find(:all, :conditions => "movie_id = #{self.id} AND kind = #{code}")
      return [] if pops.nil?
      return pops.collect{|pop| pop.user}
    else
      return []
    end
  end

  def set_user(user, what = :to_see)
    code = Movie.get_code(what)
    unless code.nil?
      pop = Popular.new(:movie => self, :user => user, :kind => code)
      self.populars << pop
    end
  end

  def remove_user(user, what = :to_see)
    code = Movie.get_code(what)
    unless code.nil?
      sql = "delete from populars where movie_id = #{self.id} AND user_id = #{user.id} AND kind = #{code}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def self.get_list(options)
    @start = options[:start] || 1
    c  = ''
    c += " AND title LIKE '%#{options[:title]}%'" if options[:title]
    if options[:release_data] && options[:release_data].include?(',')
      c += " AND year >= #{options[:release_data].split(',')[0]}"
      c += " AND year <= #{options[:release_data].split(',')[1]}" 
    end
    if options[:user_rating] && options[:user_rating].include?(',')
      c += " AND rating >= #{options[:user_rating].split(',')[0]}"
      c += " AND rating <= #{options[:user_rating].split(',')[1]}"
    end
    c += " AND genre LIKE '%#{options[:genre]}%'" if options[:genre]
    c = c[5..-1]
    puts c
    @movies = Movie.find(:all, :conditions => c, :order => 'title ASC')#, :limit => 50)
    return @movies[@start-1..@start+48]
  end

  def self.next
    @start = @start + 50
    return @movies[@start-1..@start+48]
  end

  def self.get_kind(users, kind)
    c = ''
    users.each { |u| c += "populars.user_id = #{u.id} OR " }
    c  = '(' + c[0..-5] + ') AND ' unless c.empty?
    c += "populars.kind = #{Movie.get_code(kind)}"
    puts c
    Movie.find(:all, :joins => :populars, :conditions => c, :order => 'title ASC', :group => 'movies.id')
  end
  
  def self.get_code(what)
    case what.to_sym
    when :to_see:     0
    when :seen:       1
    when :favourites: 2
    else              nil
    end
  end
end


class User < ActiveRecord::Base
  has_many :populars, :dependent => :delete_all
  has_many :movies, :through => :populars
end
