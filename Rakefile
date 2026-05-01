#!/usr/bin/env rake
require 'bundler/gem_tasks'

task :default => [:test]

require 'rake/testtask'
Rake::TestTask.new do |tt|
  tt.verbose = true
  tt.warning = true
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.patterns = %w[lib/**/*.rb]
    t.options = %w[--display-cop-names]
  end
rescue LoadError
  # rubocop not available
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  # yard not available
end

