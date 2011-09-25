# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gimdb/version"

Gem::Specification.new do |s|
  s.name        = "gimdb"
  s.version     = Gimdb::VERSION
  s.authors     = ["Enrico Pilotto"]
  s.email       = ["enrico@megiston.it"]
  s.homepage    = "https://github.com/pioz/gimdb"
  s.summary     = %q{GTK graphical interface for Internet Movie DataBase}
  s.description = %q{GTK graphical interface for Internet Movie DataBase. You can create users and save for each of them the movies to see, movies seen and favourites movies in a sqlite3 database.}

  s.add_dependency('nokogiri')
  s.add_dependency('activerecord')
  s.add_dependency('sqlite3-ruby')

  s.requirements  = ['ruby-gnome2 package version >= 0.19.3 - Debian package name: ruby-gnome2 - Mac port package name: rb-gnome']

  s.rubyforge_project = "gimdb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
