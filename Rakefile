require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    $NAME = gem.name = 'gimdb'
    $VERSION = File.exist?('VERSION') ? File.read('VERSION').strip : ''
    $SUMMARY = gem.summary = 'GTK graphical interface for Internet Movie DataBase'
    $DESCRIPTION = gem.description = 'GTK graphical interface for Internet Movie DataBase. You can create users and save for each of them the movies to see, movies seen and favourites movies in a sqlite3 database.'
    $EMAIL = gem.email = 'enrico@megiston.it'
    $HOMEPAGE = gem.homepage = 'http://github.com/pioz/gimdb'
    $AUTHORS = gem.authors = [ 'Enrico Pilotto' ]
    gem.add_dependency 'nokogiri'
    gem.add_dependency 'activerecord'
    gem.add_dependency 'sqlite3-ruby'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gimdb #{$VERSION}"
  rdoc.rdoc_files.include('README*')
end

namespace :gettext do
  desc "Update pot/po files"
  task :updatepo do
    require 'gettext/tools'
    GetText.update_pofiles('gimdb', Dir.glob("{.,lib,bin}/**/*.rb"), 'gimdb')
  end

  desc "Create mo-files"
  task :makemo do
    require 'gettext/tools'
    GetText.create_mofiles
  end
end

desc 'Generate meta deb package'
task :build_deb do
  control = <<-EOF
Package: #{$NAME}
Version: #{$VERSION}
Architecture: all
Maintainer: #{$AUTHORS.first} <#{$EMAIL}>
Depends: ruby1.8 (>= 1.8.7), ruby1.8-dev (>= 1.8.7), rubygems1.8 (>= 1.3.5), libgtk2-ruby1.8 (>= 0.19.3), libglade2-ruby1.8 (>= 0.19.3), libxml2-dev (>= 2.7.6), libxslt1-dev (>= 1.1.26), libsqlite3-dev (>= 3.6.22)
Section: misc
Priority: optional
Homepage: #{$HOMEPAGE}
Description: #{$SUMMARY}
 #{$DESCRIPTION.gsub(/(.{1,79})( +|$\n?)|(.{1,79})/, "\\1\\3\n ")[0..-3]}
EOF
  postinst = <<-EOF
#!/bin/bash
gem install #{$NAME} -v #{$VERSION} --no-rdoc --no-ri
EOF
  prerm = <<-EOF
#!/bin/bash
gem uninstall #{$NAME} -v #{$VERSION} -ax
EOF
  bin = <<-EOF
#!/bin/bash
gempath=$(gem environment gempath)
paths=$(echo $gempath | tr ":", "\n")
for p in $paths
do
  if test -x $p/bin/#{$NAME}
  then
    $p/bin/#{$NAME}
    break
  fi
done
EOF
  gnome_menu = <<-EOF
[Desktop Entry]
Name=#{$NAME.capitalize}
Version=#{$VERSION}
Comment=#{$SUMMARY}
Exec=gimdb
Terminal=false
Type=Application
StartupNotify=true
Icon=#{$NAME}
Categories=GTK;GNOME;Network;
Encoding=UTF-8
EOF
  md5sums = ''
  Dir['deb/usr/**/*'].each do |f|
    unless File.directory?(f)
      md5sums << `md5sum #{f}`
    end
  end
  `mkdir -p deb`
  `mkdir -p deb/DEBIAN/`
  `mkdir -p deb/usr/bin/`
  `mkdir -p deb/usr/share/applications/`
  `mkdir -p deb/usr/share/pixmaps/`
  File.open('deb/DEBIAN/control', 'w') {|f| f.write(control) }
  File.open('deb/DEBIAN/md5sums', 'w') {|f| f.write(md5sums) }
  File.open('deb/DEBIAN/postinst', 'w') {|f| f.write(postinst) }
  File.open('deb/DEBIAN/prerm', 'w') {|f| f.write(prerm) }
  File.open("deb/usr/bin/#{$NAME}", 'w') {|f| f.write(bin) }
  File.open("deb/usr/share/applications/#{$NAME}.desktop", 'w') {|f| f.write(gnome_menu) }
  `cp 'data/icons/#{$NAME}.png' 'deb/usr/share/pixmaps/'`
  File.chmod(0755, 'deb/DEBIAN/postinst', 'deb/DEBIAN/prerm', "deb/usr/bin/#{$NAME}")
  puts `dpkg-deb -b deb/ '#{$NAME}_#{$VERSION}_all.deb'`
end