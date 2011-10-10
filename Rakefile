require 'bundler/gem_tasks'

namespace :qt do  
  desc 'Generate rb files from ui xml and qrc files'
  task :compile_ui do
    Dir.chdir('lib/gimdb/ui/')
    `rbuic4 main_window.ui -o ui_main_window.rb`
    `rbuic4 statusbar.ui -o ui_statusbar.rb`
    `rbuic4 moviebox.ui -o ui_moviebox.rb`
    `rbuic4 manager_dialog.ui -o ui_manager_dialog.rb`
    `rbrcc icons.qrc -o ui_icons.rb`
  end    
end

__END__

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