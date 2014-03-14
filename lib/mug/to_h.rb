
if 0.to_enum.respond_to? :to_h
	warn %|Warning: "mug/to_h" may conflict with built-in Enumerable#to_h functionality|
end

unless {}.respond_to? :to_h
	warn %|Warning: "mug/to_h" does not make much sense without "to_h" (https://rubygems.org/gems/to_h)|
end

module Enumerable
	#
	# Converts +enum+ to a Hash.
	#
	# Each element of +enum+ must be a single item, or an array of two items.
	# Duplicate keys are overwritten in order.
	#
	#    [].to_h             #=> {}
	#    [1,2].to_h          #=> {1=>nil, 2=>nil}
	#    (1..2).to_h         #=> {1=>nil, 2=>nil}
	#    [[1,2],[3,4]].to_h  #=> {1=>2, 3=>4}
	#    [[1,2],[1,4]].to_h  #=> {1=>4}
	#
	def to_h
		hsh = {}
		each do |k,v,*x|
			raise ArgumentError, "invalid number of elements (#{x.length+2} for 1..2)" if x.any?
			hsh[k] = v
		end
		hsh
	end
end

=begin
Copyright (c) 2013,2014, Matthew Kerwin <matthew@kerwin.net.au>

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

