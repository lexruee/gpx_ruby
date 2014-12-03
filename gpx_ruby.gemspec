require './lib/version'

Gem::Specification.new do |s|
  s.name = 'gpx_ruby'
  s.version = GpxRuby::VERSION
  s.date = '2014-12-02'
  s.summary = 'A gpx file parser for reading gpx files.'
  s.description = 'A simple gpx file parser for reading gpx files.'
  s.authors = ['Alexander Rüeedlinger']
  s.files = Dir["lib/**/*.rb","test/**/*.rb","Rakefile"]
  s.homepage = 'http://github.com/lexruee/gpx_ruby'
  s.license = 'MIT'
  s.email = 'a.rueedlinger@gmail.com'

  s.required_ruby_version = '>=1.9.3'
  s.add_dependency 'nokogiri',  '~> 1.6', '>= 1.6.1'


end