
class Hash

  #
  # Returns a value from the hash for the given key. If the key can't be
  # found, there are several options: if default is given, then that will
  # be stored and returned; if the optional code block is specified, then
  # that will be run and its result stored and returned.
  #
  def fetch_assign key, *default
    raise ArgumentError, "wrong number of arguments (given #{default.length + 1}, expected 1..2)" if default.length > 1
    store key, (default.length == 1 ? default[0] : yield(key)) unless key? key
    fetch key
  end

end

=begin
Copyright (c) 2020, Matthew Kerwin <matthew@kerwin.net.au>

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

