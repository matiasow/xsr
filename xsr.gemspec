Gem::Specification.new do |s|
  s.name        = 'xsr'
  s.version     = '1.5.1'
  s.summary     = 'XSR: eXtremely Simple REST Client'
  s.description = 'A very simple library to talk to a REST/JSON API'
  s.authors     = ['matiasow']
  s.email       = ['matiasow@gmail.com']
  s.homepage    = 'http://github.com/matiasow/xsr'
  s.license     = 'MIT'

  s.files       =  `git ls-files`.split("\n")

  s.add_dependency 'multi_json', '~> 1.11', '>= 1.11.0'
  s.add_development_dependency 'cutest', '~> 1.2', '>= 1.2.2'
end
