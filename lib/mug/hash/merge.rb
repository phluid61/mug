
class Hash

  #
  # Returns a new hash containing the contents of +other_hash+ and the
  # contents of +hsh+. The value for each duplicate key is the value in
  # +hsh+ when it exists.
  #
  def merge_left other_hash
    merge(other_hash) {|key, left, right| left.nil? ? right : left }
  end

  #
  # Returns a new hash containing the contents of +other_hash+ and the
  # contents of +hsh+. The value for each duplicate key is the value in
  # +other_hash+ when it exists.
  #
  def merge_right other_hash
    merge(other_hash) {|key, left, right| right.nil? ? left : right }
  end

  #
  # Adds the contents of +other_hash+ to +hsh+. Entries with duplicate
  # keys are overwritten with the values from +other_hash+ if the
  # values in +hsh+ are +nil+.
  #
  def merge_left! other_hash
    merge!(other_hash) {|key, left, right| left.nil? ? right : left }
  end

  #
  # Adds the contents of +other_hash+ to +hsh+. Entries with duplicate
  # keys are overwritten with the values from +other_hash+ unless the
  # values in +other_hash+ are +nil+.
  #
  def merge_right! other_hash
    merge!(other_hash) {|key, left, right| right.nil? ? left : right }
  end

end

=begin
Copyright (c) 2018, Matthew Kerwin <matthew@kerwin.net.au>

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
