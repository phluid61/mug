Gem::Specification.new do |s|
  s.name     = 'mug'
  s.version  = '1.7.0-dev'
  s.date     = '2020-12-07'
  s.summary  = %(MUG: Matty's Ultimate Gem)
  s.description = <<EOS
== MUG: Matty's Ultimate Gem

A collection of wonders to astound the mind!!

See the documentation at http://phluid61.github.io/mug/
EOS
  s.authors  = ['Matthew Kerwin'.freeze]
  s.email    = ['matthew@kerwin.net.au'.freeze]
  s.files    = Dir['lib/**/*.rb']
  s.test_files=Dir['test/*.rb']
  s.homepage = 'http://phluid61.github.com/mug'.freeze
  s.license  = 'ISC'.freeze
end
