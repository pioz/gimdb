require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "gimdb"
    gem.summary = %Q{GTK graphics interface for Internet Movies DataBase}
    gem.description = %Q{}
    gem.email = "enrico@megiston.it"
    gem.homepage = "http://github.com/pioz/gimdb"
    gem.authors = ["Enrico Pilotto"]
    gem.add_dependency "hpricot"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gimdb #{version}"
  rdoc.rdoc_files.include('README*')
end
