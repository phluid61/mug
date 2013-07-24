#!/usr/bin/env rake

task :default => [:compile]

task :compile => 'index.html'

task 'index.html' => %w[head README.md LICENSE tail] do
	html = File.read('head')
	html << %x(Markdown.pl README.md).
			gsub( %r(<code>ruby), %(<code class="language-ruby">) ).
			gsub( %r(<p><code), %(<pre><code) ).
			gsub( %r(</code></p>), %(</code></pre>) )
	html << %(<pre id="license" class="no-highlight">) << File.read('LICENSE') << %(</pre>)
	html << File.read('tail')
	File.open('index.html', 'w') {|f| f.write(html) }
end

require 'rake/clean'
CLEAN.include %w[index.html]

