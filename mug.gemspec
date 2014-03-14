Gem::Specification.new do |s|
  s.name     = 'mug'.freeze
  s.version  = '0.2.0'.freeze
  s.date     = '2014-03-14'.freeze
  s.summary  = %(MUG: Matty's Ultimate Gem).freeze
  s.description = <<EOS
== MUG: Matty's Ultimate Gem

A collection of wonders to astound the mind!!

See the documentation at [github](https://github.com/phluid61/mug).
EOS
  s.authors  = ['Matthew Kerwin'.freeze]
  s.email    = ['matthew@kerwin.net.au'.freeze]
  s.files    = Dir['lib/**/*.rb'.freeze]
  s.test_files=Dir['test/*.rb'.freeze]
  s.homepage = 'http://phluid61.github.com/mug'.freeze
  s.license  = 'ISC License'.freeze
  s.has_rdoc = true
end
