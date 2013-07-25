
#
# A special class of Enumerator that repeatedly invokes a method.
#
# Initially the method is send to the given +obj+, but subsequent
# invocations are sent to the result of the previous invocation.
#
# Example:
#
#     0.iter_for(:next).take(5) #=> [0,1,2,3,4]
#
class Iterator < Enumerator
	#
	# Creates a new Iterator for method +meth+, to be
	# called initially on object +obj+.
	#
	# All method calls will have +args+ as parameters.
	#
	def initialize obj, meth, *args
		super() do |y|
			loop do
				y << obj
				obj = obj.send(meth, *args)
			end
		end
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

