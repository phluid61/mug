
class Proc
	#
	# Curries this Proc and partially applies parameters.
	# If a sufficient number of arguments are supplied, it passes the
	# supplied arguments to the original proc and returns the result.
	# Otherwise, returns another curried proc that takes the rest of
	# arguments.
	#
	def apply(*args)
		curry.call(*args)
	end
end

class Method
	if RUBY_VERSION < '2.2'
		#
		# Returns a curried proc. If the optional arity argument is given,
		# it determines the number of arguments. A curried proc receives
		# some arguments. If a sufficient number of arguments are supplied,
		# it passes the supplied arguments to the original proc and returns
		# the result. Otherwise, returns another curried proc that takes the
		# rest of arguments.
		#
		def curry(n=nil)
			if n
				to_proc.curry n
			else
				to_proc.curry
			end
		end
	end

	#
	# Curries this Method and partially applies parameters.
	# If a sufficient number of arguments are supplied, it passes the
	# supplied arguments to the original proc and returns the result.
	# Otherwise, returns another curried proc that takes the rest of
	# arguments.
	#
	def apply(*args)
		curry.call(*args)
	end
end

=begin
Copyright (c) 2014, Matthew Kerwin <matthew@kerwin.net.au>

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
