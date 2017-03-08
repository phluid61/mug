
class Hash

  #
  # Returns a new Hash, whose value is the same as this
  # one, with any extras in +other_hash+ added in.
  #
  # Useful for default options.
  #
  # Example:
  #     opts = {:a => 1, :b => 2 }
  #     dflt = {:a => 0, :x => 9 }
  #     opts |= dflt # => opts = {:a=>1, :b=>2, :x=>9}
  #
  def | other_hash
    other_hash.merge self
  end

  #
  # Adds the contents of +other_hash+ to +hsh+.
  # Entries with duplicate keys are overwritten with the
  # values from +other_hash+
  #
  def + other_hash
    merge other_hash
  end

  #
  # Appends stuff to the hash.
  #
  # If +o+ is a Hash, this is identical to calling #merge!
  # If +o+ is an Array with two elements, it is interpreted as [key,value]
  # If +o+ can be converted to a hash with #to_h, this is identical to calling #merge!
  # Otherwise an ArgumentError is raised.
  #
  # Example:
  #     h = {}
  #     h << {:a=>0}       # h = {:a=>0}
  #     h << {:b=>2,:c=>3} # h = {:a=>0,:b=>2,:c=>3}
  #     h << [:a,1]        # h = {:a=>1,:b=>2,:c=>3}
  #
  def << o
    if o.respond_to? :to_hash
      merge! o.to_hash
    elsif o.respond_to?(:to_a) && (a = o.to_a) && a.length == 2
      tap { store a[0], a[1] }
    elsif o.respond_to? :to_h
      merge! o.to_h
    else
      raise ArgumentError, "#{o.class.name} is not a Hash"
    end
  end
end

=begin
Copyright (c) 2017, Matthew Kerwin <matthew@kerwin.net.au>

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

