#require "#{$GIMDB_PATH}/src/model"


module GtkGimdb

  class ManagerBox < Gtk::HBox
    include GetText


    def initialize(klass, field)
      bindtextdomain($DOMAIN, $LOCALEDIR, nil, 'UTF-8')
      super()
      @comboboxentry = Gtk::ComboBoxEntry.new
      @image_add  = Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::BUTTON)
      @image_edit = Gtk::Image.new(Gtk::Stock::EDIT, Gtk::IconSize::BUTTON)
      @image_del  = Gtk::Image.new(Gtk::Stock::DELETE, Gtk::IconSize::BUTTON)
      @button = Gtk::Button.new(_('Add'))
      @button.image = @image_add
      @button.image.show
      @klass = klass.to_s.classify.constantize
      @field = field
      @objs = @klass.all.collect{|o| o.send(@field)}
      @status = :add
      @pos = 0
      setting_up { |t| yield(t) }
    end


    private

    
    def setting_up
      reorder

      @button.signal_connect('clicked') do
        if @status == :add
          o = @klass.new(@field.to_sym => @comboboxentry.active_text)
          if o.save
            @objs << @comboboxentry.active_text
            yield("New #{@klass.to_s.downcase} added") if block_given?
          end
          reorder
        elsif @status == :edit
          o = @klass.send("find_by_#{@field}", @obj_to_edit)
          unless o.nil?
            o.send("#{@field}=", @comboboxentry.active_text)
            if o.save
              @objs.delete(@obj_to_edit)
              @objs << @comboboxentry.active_text
              yield("#{@klass} edited") if block_given?
            end
          end
          reorder
        elsif @status == :del
          o = @klass.send("find_by_#{@field}", @comboboxentry.active_text)
          unless o.nil?
            o.destroy
            @objs.delete(@comboboxentry.active_text)
            yield("#{@klass} deleted") if block_given?
          end
          reorder
        else
          nil
        end
      end

      @comboboxentry.signal_connect('changed') do
        @pos = @comboboxentry.active if @comboboxentry.active > -1
        if @pos == 0
          @status = :add
          @button.label = _('Add')
          @button.image = @image_add          
        elsif @objs.include?(@comboboxentry.active_text)
          @status = :del
          @obj_to_edit = @comboboxentry.active_text
          @button.label = _('Delete')
          @button.image = @image_del
        else
          @status = :edit
          @button.label = _('Edit')
          @button.image = @image_edit
        end
        @button.image.show
      end

      table = Gtk::Table.new(1, 2)
      table.attach(@comboboxentry, 0,1, 0,1)
      table.attach(@button, 1,2, 0,1, Gtk::SHRINK, Gtk::EXPAND|Gtk::FILL)
      self.pack_start(table)
      self.show_all
    end


    def reorder
      @objs.sort!
      (@objs.size + 2).times { @comboboxentry.remove_text(0) }
      @comboboxentry.append_text('')
      @objs.each do |o|
        @comboboxentry.append_text(o)
      end
      @comboboxentry.active = 0
    end

  end

end
