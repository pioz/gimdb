require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => "#{$APP_LOCAL_PATH || '.'}/db.sqlite3"
)

if(!ActiveRecord::Base.connection.tables.include?('movies') ||
   !ActiveRecord::Base.connection.tables.include?('users')  ||
   !ActiveRecord::Base.connection.tables.include?('populars'))
  ActiveRecord::Schema.define do
    create_table :movies do |t|
      t.string   :code,       :unique => true, :null => false
      t.string   :title,      :null => false
      t.string   :image_url
      t.string   :image_path
      t.integer  :year,       :limit => 4
      t.integer  :votes
      t.float    :rating
      t.text     :outline
      t.string   :credit
      t.string   :genre
      t.float    :runtime
      t.datetime :updated_at, :null => false, :default => Time.now
    end

    create_table :users do |t|
      t.string  :name,     :unique => true, :null => :false
      t.boolean :selected, :default => true
    end

    create_table :populars, :id => false do |t|
      t.references :movie
      t.references :user
      t.string     :kind, :null => false
    end

    add_index :movies, :id, :unique
    add_index :populars, [:movie_id, :user_id, :kind], :unique
  end
end

KINDS = [:to_see, :seen, :favourites]

class Popular < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  validates :kind, :presence => {:in => KINDS}
end


class Movie < ActiveRecord::Base
  has_many :populars, :dependent => :delete_all
  has_many :users, :through => :populars

  def get_users(kind = :to_see)
    pops = Popular.where("movie_id = ? AND kind = ?", self.id, kind)
    return [] if pops.nil?
    return pops.collect{|pop| pop.user}    
  end

  def set_user(user, kind = :to_see)
    pop = Popular.new(:movie => self, :user => user, :kind => kind)
    self.populars << pop    
  end

  def remove_user(user, kind = :to_see)
    sql = "delete from populars where movie_id = #{self.id} AND user_id = #{user.id} AND kind = #{kind}"
    ActiveRecord::Base.connection.execute(sql)    
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
    @movies = Movie.where(c).order('title ASC')#.limit(50)
    return @movies[@start-1..@start+48]
  end

  def self.next
    @start = @start + 50
    return @movies[@start-1..@start+48] || []
  end

  def self.get_kind(users, kind)
    c = ''
    users.each { |u| c += "populars.user_id = #{u.id} OR " }
    c  = '(' + c[0..-5] + ') AND ' unless c.empty?
    c += "populars.kind = '#{kind}'"
    Movie.select('movies.*').where(c).joins(:populars).order('title ASC').group('movies.id')
  end

end


class User < ActiveRecord::Base
  has_many :populars, :dependent => :delete_all
  has_many :movies, :through => :populars
  validates_presence_of :name
  validates_uniqueness_of :name
end

