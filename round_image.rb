require 'gtk2'


module GtkGimdb

  module DrawRoundRectangle
    def draw_round_rectangle(x, y, w, h, r)
      self.move_to(x, y+r)
      self.curve_to(x, y, x, y, x+r, y)
      self.line_to(x+w-r, y)
      self.curve_to(x+w, y, x+w, y, x+w, y+r)
      self.line_to(x+w, y+h-r)
      self.curve_to(x+w, y+h, x+w, y+h, x+w-r, y+h)
      self.line_to(x+r, y+h)
      self.curve_to(x, y+h, x, y+h, x, y+h-r)
      self.close_path
      return self.copy_path
    end
  end

  # Add 2 drawing methods on Cairo::Context class
  # (Bypass private - acts_as Rails style)
  Cairo::Context.send(:include, DrawRoundRectangle)

  class RoundImage < Gtk::DrawingArea

    def initialize(image_path)
      super()

      # Config variables
      @border_color = [0.73, 0.73, 0.73]

      @pixbuf = Gdk::Pixbuf.new(image_path)
      self.set_size_request(@pixbuf.width + 2, @pixbuf.height + 2) # 2 is border width
      self.signal_connect('expose_event') { |w,e| self.expose_event(e) }
    end


    def expose_event(e)
      draw
      return false
    end

    
    private


    def draw
      x = self.allocation.x
      y = self.allocation.y
      w = self.width_request
      h = self.height_request

      # Prepare image surface
      @image = Cairo::ImageSurface.new(Cairo::FORMAT_RGB24, @pixbuf.width, @pixbuf.height)
      image_context = Cairo::Context.new(@image)
      image_context.set_source_pixbuf(@pixbuf, 0.0, 0.0)
      image_context.paint

      puts "#{x}-#{y} : #{w} - #{h}"

      context = self.window.create_cairo_context

      # Shadow
      context.set_source_rgb(*(@border_color))
      context.translate(0.5, 0.5)
      path = context.draw_round_rectangle(x, y, w, h, 40)
      context.translate(-0.5, -0.5)
      context.stroke

      # Image
      context.set_source_rgb(0,0,0)
      context.draw_round_rectangle(x, y, w, h, 40)
      context.clip
      context.set_source(@image, 0.0, 0.0)
      context.paint
    end

  end

end
