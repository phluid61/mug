
class Object

	#
	# Returns either +obj+ or +default+, depending on the falsiness of +obj+.
	#
	# If a block is given, +obj+ is yielded to it; if it returns truthy,
	# +default+ is returned, otherwise +obj+ is returned.
	#
	def and default
		if block_given?
			yield(self) ? default : self
		else
			self && default
		end
	end

	#
	# Returns either +obj+ or +default+, depending on the truthiness of +obj+.
	#
	# If a block is given, +obj+ is yielded to it; if it returns truthy,
	# +obj+ is returned, otherwise +default+ is returned.
	#
	def or default
		if block_given?
			yield(self) ? self : default
		else
			self || default
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

