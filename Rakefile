#!/usr/bin/env rake

task :default => [:compile]

task :compile => 'index.html'

task 'index.html' => %w[head README.md LICENSE tail] do
  toc = '<div id="toc"><ul>'
  readme = %x(./markdown README.md)
  readme.gsub!(/<h2>([^<]+)<\/h2>/) do |m|
    name = $1
    id = $1.gsub /^\W+/, '_'
    toc << "<li><a href=\"\#gem-#{id}\">#{name}</a></li>"
    "<h2 id=\"gem-#{id}\">#{name}</h2>"
  end
  toc << '</ul></div>'

  html = File.read('head')
  html << toc
  html << readme
  html << %(<pre id="license" class="no-highlight">) << File.read('LICENSE') << %(</pre>)
  html << %x(./markdown code_of_conduct.md)
  html << File.read('tail')
  File.open('index.html', 'w') {|f| f.write(html) }
end

task :push => 'index.html' do
  system 'git commit -a -m "rebuild gh-pages from master"' and system 'git push'
end

require 'rake/clean'
CLEAN.include %w[index.html]

