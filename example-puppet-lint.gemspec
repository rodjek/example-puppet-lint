Gem::Specification.new do |s|
  s.name = 'example-puppet-lint'
  s.version = '0.0.1'
  s.homepage = 'https://github.com/rodjek/example-puppet-lint/'
  s.summary = 'An example of how to distribute custom puppet-lint checks.'
  s.description = 'An example of how to distribute custom puppet-lint checks as gems.'

  s.files = [
    'lib/puppet-lint/plugins/augeas.rb',
    'example-puppet-lint.gemspec',
  ]

  s.require_paths = ["lib"]

  s.add_dependency 'puppet-lint', '>= 0.4.0'

  s.authors = ['Tim Sharpe']
  s.email = 'tim@sharpe.id.au'
end
