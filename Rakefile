#!/usr/bin/env rake

task :default => [:compile]

task :compile => 'index.html'

task 'index.html' => %w[head README.md LICENSE tail] do
  toc = '<div id="toc"><ul>'
  readme = %x(./markdown README.md)
  raise "markdown failed for README.md (exit #{$?.exitstatus})" unless $?.success?
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
  coc = %x(./markdown code_of_conduct.md)
  raise "markdown failed for code_of_conduct.md (exit #{$?.exitstatus})" unless $?.success?
  html << coc
  html << File.read('tail')
  File.open('index.html', 'w') {|f| f.write(html) }
end

require 'rake/clean'
CLEAN.include %w[index.html]

