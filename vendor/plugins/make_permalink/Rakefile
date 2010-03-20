require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run specs.'
task :default => :spec

desc "Runs the spec suite"
task :spec do
  spec_path = "#{File.dirname(__FILE__)}/spec"
  sh "spec #{spec_path} -O #{spec_path}/spec.opts "
end

desc 'Generate documentation for the make_permalink plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MakePermalink'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
