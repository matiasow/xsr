Gem::Specification.new do |s|
  s.name        = 'xsr'
  s.version     = '1.0.0'
  s.summary     = "XSR: eXtremely Simple REST Client"
  s.description = "A very simple library to talk to a REST/JSON API"
  s.authors     = ["Matias Owsianik"]
  s.email       = ['matiasow@gmail.com']
  s.homepage    = 'http://github.com/matiasow/xsr'
  s.license     = 'MIT'

  s.files       =  `git ls-files`.split("\n")

  s.add_dependency "multi_json"
  s.add_development_dependency "cutest"
end
