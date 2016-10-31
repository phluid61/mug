
class MatchData

  # Returns a Hash object of capture position => captured string.
  #
  # The capture positions are either all Strings or all Integers,
  # depending on whether the original Regexp had named capture
  # groups or not.
  def to_h
    if names.empty?
      Hash[ captures.each_with_index.map{|v,i| [i+1, v] } ]
    else
      Hash[ names.map{|n| [n, self[n]] } ]
    end
  end

  # Returns a Hash object of capture name => captured string.
  def named_captures
    Hash[ names.map{|n| [n, self[n]] } ]
  end

  # Returns a Hash object of capture position => captured string.
  #
  # If +include_names+ is given and true, treats named captures
  # as positional captures.
  #
  # WARNING: if mixing named and positional captures, no positional
  # captures will be available using this method!
  def positional_captures include_names: false
    return {} unless names.empty? || include_names
    Hash[ captures.each_with_index.map{|v,i| [i+1, v] } ]
  end

end

=begin
Copyright (c) 2016, Matthew Kerwin <matthew@kerwin.net.au>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

Additional license is granted to the Ruby Core Team to use this software
in the ruby core or ruby standard libraries without including the above
copyright notice nor this permission notice.  Subsequently, such a copy
of this software becomes wholly subject to the relevant licensing terms
of the ruby core or ruby standard libraries.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
=end

