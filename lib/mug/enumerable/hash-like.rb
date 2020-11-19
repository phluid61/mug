
module Enumerable

  ##
  # Calls +block+ once for each key in the enum, passing the key-value pair as parameters.
  # If no block is given, an enumerator is returned instead.
  #
  # @call-seq each_pair {| key, value | block } -> hsh
  # @call-seq each_pair -> an_enumerator
  #
  def each_pair
    return enum_for(:each_pair) unless block_given?
    each_with_index {|e,i| yield i, e }
  end

  ##
  # Calls +block+ once for each key in the enum, passing the key as a parameter.
  # If no block is given, an enumerator is returned instead.
  #
  # @call-seq each_key {| key | block } -> hsh
  # @call-seq each_key -> an_enumerator
  #
  def each_key
    return enum_for(:each_key) unless block_given?

    # FIXME
    each_with_index {|_,i| yield i }
  end

  alias each_value each_entry

  ##
  # Returns a value from the enum for the given key. If the key can't be
  # found, there are several options: With no other arguments, it will
  # raise a +KeyError+ exception; if +default+ is given, then that will
  # be returned; if the optional code block is specified, then that will
  # be run and its result returned.
  #
  # @call-seq fetch(key [, default] ) -> obj
  # @call-seq fetch(key) { |key| block } -> obj
  #
  def fetch *args
    raise ArgumentError, "incorrect number of arguments (#{args.length} for 1..2)" if args.length < 1 || args.length > 2
    key, default = *args

    each_pair do |k,v|
      return v if k == key
    end
    if args.length > 1
      default
    elsif block_given?
      yield key
    else
      raise KeyError, 'key not found'
    end
  end

  ##
  # Returns an array containing the values associated with the given keys
  # but also raises +KeyError+ when one of keys can't be found.
  # Also see +#values_at+ and +#fetch+.
  #
  # @call-seq fetch_values(key, ...) -> array
  # @call-seq fetch_values(key, ...) { |key| block } -> array
  #
  def fetch_values *keys
    key_map = {}
    keys.each_with_index do |key, index|
      key_map[key] ||= []
      key_map[key] << index
    end

    remain = keys.length
    result = [nil] * keys.length
    define = [nil] * keys.length

    each_pair do |k,v|
      break if remain < 1

      key_indices = key_map[k]
      next unless key_indices

      key_indices.each do |key_index|
        result[key_index] = v
        define[key_index] = true
        remain -= 1
      end
    end

    if remain > 0
      if block_given?
        define.each_with_index do |isdef, index|
          next if isdef
          result[index] = yield keys[index]
        end
      else
        index = define.index nil
        raise KeyError, "key not found: #{keys[index].inspect}"
      end
    end

    result
  end

  alias key find_index

  ##
  # Returns +true+ if the given key is present in this enum.
  #
  # @call-seq key?(key) -> true or false
  #
  def key? key
    each_pair.find {|k, _| key == k } && true
  end
  alias has_key? key?

  ##
  # Returns a new array populated with the keys from this enum.
  #
  # @call-seq keys -> array
  #
  def keys
    each_with_index.map {|_, index| index }
  end

  ##
  # Returns the number of key-value pairs in the hash.
  #
  # @call-seq length -> integer
  #
  def length
    reduce(0) {|sum,_| sum + 1 }
  end
  alias size length

  undef member? # FIXME: do something about this? maybe warn?
  ##
  # Returns true if the given key is present in this enum.
  #
  # @call-seq member?(key) -> true or false
  #
  def member? key
    fetch(key, nil) && true
  end

  ##
  # Returns a hash containing only the given keys and their values.
  #
  # @call-seq slice(*keys) -> a_hash
  #
  def slice *keys
    missing = {}
    values = fetch_values(*keys) {|key| missing[key] = nil }

    result = {}
    values.each_with_index do |val, i|
      key = keys[i]
      next if missing.key? key
      next if result.key? key
      result[key] = val
    end
    result
  end

  ##
  # Returns a new hash with the results of running the block once for every key.
  # If no block is given, an enumerator is returned instead.
  #
  # @call-seq transform_keys {|key| block } -> new_hash
  # @call-seq transform_keys -> an_enumerator
  #
  def transform_keys
    return enum_for(:transform_keys) unless block_given?
    result = {}
    each_pair do |key, value|
      newkey = yield key
      result[newkey] = value
    end
    result
  end

  ##
  # Returns a new hash with the results of running the block once for every value.
  # If no block is given, an enumerator is returned instead.
  #
  # @call-seq transform_values {|value| block } -> new_hash
  # @call-seq transform_values -> an_enumerator
  #
  def transform_values
    return enum_for(:transform_values) unless block_given?
    result = {}
    each_pair do |key, value|
      newvalue = yield value
      result[key] = newvalue
    end
    result
  end

  ##
  # Returns +true+ if the given value is present for some key.
  #
  # @call-seq value?(value) -> true or false
  #
  def value? value
    include? value
  end
  alias has_value? value?

  ##
  # Returns a new array populated with the values from this enum.
  #
  # @call-seq values -> array
  #
  def values
    to_a
  end

  ##
  # Return an array containing the values associated with the given keys.
  #
  # @call-seq values_at(key, ...) -> array
  #
  def values_at *keys
    fetch_values(*keys) {|key| nil }
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

