#!/usr/bin/env ruby
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'

class GimdbGlade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    
  end
  
  def on_quit_clicked(widget, arg0)
    puts "on_quit_clicked() is not implemented yet."
  end
  def on_search_clicked(widget, arg0)
    puts "on_search_clicked() is not implemented yet."
  end
  def on_clean_clicked(widget)
    puts "on_clean_clicked() is not implemented yet."
  end
end

# Main program
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "gimdb.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  GimdbGlade.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
