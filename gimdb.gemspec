# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gimdb}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Enrico Pilotto"]
  s.date = %q{2010-05-14}
  s.default_executable = %q{gimdb}
  s.description = %q{GTK graphical interface for Internet Movie DataBase. You can create users and save for each of them the movies to see, movies seen and favourites movies in a sqlite3 database.}
  s.email = %q{enrico@megiston.it}
  s.executables = ["gimdb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/gimdb",
     "data/gimdb.glade",
     "data/icons/favourites.png",
     "data/icons/imdb.png",
     "data/icons/imdb_icon.png",
     "data/icons/no_poster.png",
     "data/icons/seen.png",
     "data/icons/spinner16x16.gif",
     "data/icons/to_see.png",
     "data/icons/users.png",
     "data/icons/users_edit.png",
     "data/locale/it/LC_MESSAGES/gimdb.mo",
     "gimdb.gemspec",
     "lib/imdb.rb",
     "po/gimdb.pot",
     "po/it/gimdb.po",
     "src/controller.rb",
     "src/gimdb.rb",
     "src/manager_box.rb",
     "src/model.rb",
     "src/movie_box.rb"
  ]
  s.homepage = %q{http://github.com/pioz/gimdb}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{GTK graphical interface for Internet Movie DataBase}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_runtime_dependency(%q<sqlite3-ruby>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
  end
end

