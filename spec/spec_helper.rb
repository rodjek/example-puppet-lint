require 'puppet-lint'
require 'pathname'

PuppetLint::Plugins.load_from_gems

if Gem::Specification.respond_to? :find_by_name
  gempath = Pathname.new(Gem::Specification.find_by_name('puppet-lint').full_gem_path)
else
  gempath = Pathname.new(Gem.searcher.find('puppet-lint').full_gem_path)
end

load gempath + 'spec/spec_helper.rb'
