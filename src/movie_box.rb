module GtkGimdb

  class MovieBox < Gtk::VBox
    include GetText
    attr_reader :movie


    def initialize(movie, users = [])
      bindtextdomain($DOMAIN, $LOCALEDIR, nil, 'UTF-8')
      super()
      @movie = movie
      @users = users
      setting_up
      self.show_all
    end    

    def has_poster?
      @movie.image_path && File.exist?(@movie.image_path)
    end

    def set_poster
      @img.file = @movie.image_path if has_poster?      
    end


    private


    def setting_up
      hbox = Gtk::HBox.new
      hbox.spacing = 10
      vbox = Gtk::VBox.new
      vbox.spacing = 10
      hbox1 = Gtk::HBox.new
      hbox1.spacing = 50
      hbox2 = Gtk::HBox.new
      hbox2.spacing = 50

      @img = Gtk::Image.new("#{$GIMDB_PATH}/data/icons/no_poster.png")
      set_poster
      @img.set_tooltip_text("Code: #{@movie.code}")
      hbox.pack_start(@img, false)

      title = Gtk::Label.new
      year = (@movie.year.nil? || @movie.year == 0) ? '' : "(#{@movie.year})"
      title.markup = "<a href='http://www.imdb.it/title/#{@movie.code}/'><span color='#000' underline='none' size='large' weight='ultrabold'>#{@movie.title}</span></a> #{year}"
      hbox1.pack_start(title, false)

      rating = Gtk::Label.new
      rating.markup = "#{@movie.rating}/10" unless @movie.rating.nil? || @movie.rating == 0
      rating.set_tooltip_text(@movie.votes.to_s + ' votes') unless @movie.votes.nil? || @movie.votes == 0
      hbox1.pack_end(rating, false)

      vbox.pack_start(hbox1, false)

      outline = Gtk::TextView.new
      outline.buffer.text = @movie.outline || ''
      outline.editable = false
      outline.wrap_mode = Gtk::TextTag::WRAP_WORD_CHAR
      outline.cursor_visible = false
      outline.modify_base(Gtk::STATE_NORMAL, Gdk::Color.parse('#edeceb'))
      vbox.pack_start(outline, false)

      credit = Gtk::Label.new
      credit.markup = @movie.credit || ''
      credit.set_alignment(0.0, 0.0)
      vbox.pack_start(credit, false)

      genre = Gtk::Label.new
      genre.text = @movie.genre.nil? ? '' : _('Genres') + ': ' + @movie.genre.gsub('|', ' | ')
      hbox2.pack_start(genre, false)

      runtime = Gtk::Label.new
      unless @movie.runtime.nil? || @movie.runtime == 0
        runtime.text = @movie.runtime.to_i.to_s + ' mins'
        time = Time.now.midnight + @movie.runtime * 60
        runtime.set_tooltip_text("#{time.hour}:#{"%02d" % time.min}")
      end
      hbox2.pack_end(runtime, false)

      vbox.pack_start(hbox2, false)

      vbox.pack_start(add_users_info, false) if @users.size > 0
      
      hbox.pack_start(vbox)
      
      self.pack_start(hbox)
      self.pack_start(Gtk::HSeparator.new, false)
      self.spacing = 10
    end

    def add_users_info
      table = Gtk::Table.new(@users.size + 1, 4)
      table.attach(Gtk::Label.new, 0,1, 0,1, Gtk::SHRINK)
      table.attach(Gtk::Label.new.set_markup(_('<b>To see</b>')), 1,2, 0,1, Gtk::SHRINK, Gtk::EXPAND|Gtk::FILL, 10)
      table.attach(Gtk::Label.new.set_markup(_('<b>Seen</b>')), 2,3, 0,1, Gtk::SHRINK, Gtk::EXPAND|Gtk::FILL, 10)
      table.attach(Gtk::Label.new.set_markup(_('<b>Favourites</b>')), 3,4, 0,1, Gtk::SHRINK)
      @users.each_with_index do |u, i|
        row = i + 1
        table.attach(Gtk::Label.new(u.name), 0,1, row,row+1, Gtk::SHRINK)
        table.attach(UserCheckButton.new(u, @movie, :to_see), 1,2, row,row+1, Gtk::SHRINK)
        table.attach(UserCheckButton.new(u, @movie, :seen), 2,3, row,row+1, Gtk::SHRINK)
        table.attach(UserCheckButton.new(u, @movie, :favourites), 3,4, row,row+1, Gtk::SHRINK)
      end
      return table
    end


    class UserCheckButton < Gtk::CheckButton
      def initialize(user, movie, what)
        super()
        self.active = movie.get_users(what).include?(user)
        self.signal_connect('toggled') do |b|
          if b.active?
            movie.set_user(user, what)
          else
            movie.remove_user(user, what)
          end
        end
      end
    end

  end

end

