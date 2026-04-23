#!/usr/bin/env rake

task :default => [:compile]

task :compile => 'index.html'

EXTRA_HEAD = <<~HTML
  <link rel="stylesheet" href="highlight.js/styles/default.css">
  <link rel="stylesheet" href="page.css">
  <script src="highlight.js/highlight.pack.js"></script>
  <script>hljs.initHighlightingOnLoad();</script>
HTML

task 'index.html' => %w[README.md LICENSE] do
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

  html = "---\n"
  html << "layout: default\n"
  html << "title: \"Matty's Ultimate Gem\"\n"
  html << "extra_head: |\n"
  EXTRA_HEAD.each_line {|line| html << "  #{line}" }
  html << "---\n"
  html << toc
  html << readme
  html << %(<pre id="license" class="no-highlight">) << File.read('LICENSE') << %(</pre>)
  coc = %x(./markdown code_of_conduct.md)
  raise "markdown failed for code_of_conduct.md (exit #{$?.exitstatus})" unless $?.success?
  html << coc
  File.open('index.html', 'w') {|f| f.write(html) }
end

require 'rake/clean'
CLEAN.include %w[index.html]

