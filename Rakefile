ENV['RACK_ENV'] = 'development'

require 'rake/testtask'
require 'bundler/setup'
require 'mongoid'

require_relative 'module/skeleton_app'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/lib/skeleton_app/*_spec.rb']
  t.verbose = true
end

Mongoid.load!("config/mongoid.yml", ENV['RACK_ENV'])

task :default => :test
