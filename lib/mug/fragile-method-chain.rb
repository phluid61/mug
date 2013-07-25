
#
# Invokes a method chain until one method returns a falsy value.
#
# For example:
#
#     a._?.b.c.d._!
#     nested_hash._?[:a][:b][:c]._!
#
class FragileMethodChain
	#
	# Creates a FragileMethodChain which will send its first method to +o+
	#
	def initialize o
		@o = o
		@chain = []
	end

	#
	# Finalises the FragileMethodChain.
	#
	# The final result will be the first +nil+ or +false+ value
	# returned in the chain, or its end result.
	#
	def _!
		@chain.inject(@o) do |o,x|
			a,b = x
			break o unless o
			o.__send__(*a, &b)
		end
	end

	# Record the method args/block
	def method_missing *a, &b #:nodoc:
		@chain << [a,b]
		self
	end

	# Explicitly record :_? as a method in the chain.
	def _? #:nodoc:
		@chain << [[ :_? ],nil]
		self
	end
end

class Object
	#
	# Begins a FragileMethodChain.
	#
	def _?
		FragileMethodChain.new(self)
	end
end

=begin
Copyright (c) 2013, Matthew Kerwin <matthew@kerwin.net.au>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
=end

