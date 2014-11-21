Gem::Specification.new do |s|
  s.name     = 'mug'
  s.version  = '0.2.6'
  s.date     = '2014-11-21'
  s.summary  = %(MUG: Matty's Ultimate Gem)
  s.description = <<EOS
== MUG: Matty's Ultimate Gem

A collection of wonders to astound the mind!!

See the documentation at <https://github.com/phluid61/mug>.
EOS
  s.authors  = ['Matthew Kerwin'.freeze]
  s.email    = ['matthew@kerwin.net.au'.freeze]
  s.files    = Dir['lib/**/*.rb']
  s.test_files=Dir['test/*.rb']
  s.homepage = 'http://phluid61.github.com/mug'.freeze
  s.license  = 'ISC License'.freeze
  s.has_rdoc = true
end
