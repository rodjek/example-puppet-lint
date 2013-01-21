Gem::Specification.new do |s|
  s.name          = 'example-puppet-lint'
  s.version       = '0.0.1'
  s.homepage      = 'https://github.com/rodjek/example-puppet-lint/'
  s.summary       = 'An example of how to distribute custom puppet-lint checks.'
  s.authors       = ['Tim Sharpe']
  s.email         = 'tim@sharpe.id.au'
  s.require_paths = ["lib"]
  s.description   = <<-EOF
    An example of how to distribute custom puppet-lint checks as gems.
  EOF

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency             'puppet-lint', '>= 0.4.0'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end
