
class MatchData

  # Iterates over each capture group in the MatchData object,
  # including +$&+ (the entire matched string), yielding the
  # captured string.
  def each &_b
    return enum_for(:each) unless block_given?
    to_a.each{|v| yield v }
  end

  # Iterates over each capture group in the MatchData object,
  # yielding the capture position and captured string.
  #
  # The capture positions are either all Strings or all Integers,
  # depending on whether the original Regexp had named capture
  # groups or not.
  def each_capture &_b
    return enum_for(:each_capture) unless block_given?
    if names.empty?
      captures.each_with_index{|v,i| yield i+1, v }
    else
      names.each{|n| yield n, self[n] }
    end
  end

  # Iterates over each named capture group in the MatchData object,
  # yielding the capture name and string.
  def each_named_capture &_b
    return enum_for(:each_named_capture) unless block_given?
    names.each{|n| yield n, self[n] }
  end

  # Iterates over each positional capture group in the MatchData object,
  # yielding the capture position and string.
  #
  # If +include_names+ is given and true, treats named captures
  # as positional captures.
  #
  # WARNING: if mixing named and positional captures, no positional
  # captures will be available using this method!
  def each_positional_capture include_names: false, &_b
    return enum_for(:each_positional_capture, include_names: include_names) unless block_given?
    return unless names.empty? || include_names
    captures.each_with_index{|v,i| yield i+1, v }
  end

end

=begin
Copyright (c) 2018, Matthew Kerwin <matthew@kerwin.net.au>

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

