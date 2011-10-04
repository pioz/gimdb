# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'gimdb/version'

Gem::Specification.new do |s|
  s.name        = 'gimdb'
  s.version     = Gimdb::VERSION
  s.authors     = ['Enrico Pilotto']
  s.email       = ['enrico@megiston.it']
  s.homepage    = 'https://github.com/pioz/gimdb'
  s.summary     = %q{QT graphical interface for Internet Movie DataBase}
  s.description = %q{QT graphical interface for Internet Movie DataBase. You can create users and save for each of them the movies to see, movies seen and favourites movies in a sqlite3 database.}

  s.add_dependency('nokogiri')
  s.add_dependency('sqlite3')
  s.add_dependency('activerecord', '>= 3.1.0')
  s.add_dependency('qtbindinds', '>= 4.6')

  s.requirements  = ['libqt4 package version >= 4.7.2 - Debian package name: libqt4-dev - Mac port package name: qt4']

  s.rubyforge_project = 'gimdb'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
