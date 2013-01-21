require 'rake'
require 'rspec/core/rake_task'

task :default => :test

RSpec::Core::RakeTask.new(:test) do |t|
  t.rcov = true
  t.rcov_opts = '--exclude "spec"'
end
