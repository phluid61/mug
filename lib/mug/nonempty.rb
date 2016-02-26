
class Array
	#
	# Returns +true+ if +self+ contains elements.
	#
	def nonempty?
		!empty?
	end
end

class Hash
	#
	# Returns +true+ if +hsh+ contains elements.
	#
	def nonempty?
		!empty?
	end
end

class String
	#
	# Returns +true+ if +str+ has a length greater than zero.
	#
	def nonempty?
		!empty?
	end
end

class Symbol
	#
	# Returns that +sym+ is not :"".
	#
	def nonempty?
		!empty?
	end
end

class << ENV
	#
	# Returns true when there are environment variables.
	#
	def nonempty?
		!empty?
	end
end

class Queue
	#
	# Returns +true+ if the queue is not empty.
	#
	def nonempty?
		!empty?
	end
end

=begin
Copyright (c) 2016, Matthew Kerwin <matthew@kerwin.net.au>

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

