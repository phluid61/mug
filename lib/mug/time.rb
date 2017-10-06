
class Time

  #
  # Returns the number of seconds since the time represented by
  # this Time object.
  #
  #     start = Time.now
  #     #...
  #     duration = start.to_now
  #
  def to_now
    #if Time.respond_to? :unix_timestamp
    #  Time.unix_timestamp - to_i
    #else
      self.class.now - self
    #end
  end

  #
  # Returns the number of seconds until the time represented by
  # this Time object.
  #
  #     target = Time.new 2117, 1, 1, 0, 0, 0
  #     sleep target.from_now
  #
  def from_now
    #if time.respond_to? :unix_timestamp
    #  to_i - Time.unix_timestamp
    #else
      self - self.class.now
    #end
  end

  class << self

    #
    # Returns the number of seconds until +t+
    #
    def until t
      t.from_now
    end

    #
    # Returns the number of since since +t+
    #
    def since t
      t.to_now
    end

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

