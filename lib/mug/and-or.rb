
class Object

  #
  # Returns either +obj+ or +default+, depending on the falsiness of +obj+.
  #
  # If a block is given, +obj+ is yielded to it; if it returns truthy,
  # +default+ is returned, otherwise +obj+ is returned.
  #
  # @param default [Object] the value to return if the condition is met
  # @yield [obj] optional block to determine the condition
  # @return [Object] either +self+ or +default+
  #
  # @example
  #   require 'mug/and-or'
  #
  #   get_a_list.and(default_list, &:empty?).do_something
  #
  def and default, &_block
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
  # @param default [Object] the value to return if the condition is met
  # @yield [obj] optional block to determine the condition
  # @return [Object] either +self+ or +default+
  #
  # @example
  #   require 'mug/and-or'
  #
  #   data_store.get_env_hash.or(default_hash).do_something
  #
  def or default, &_block
    if block_given?
      yield(self) ? self : default
    else
      self || default
    end
  end

  #
  # Calls +block+ if +obj+ is truthy.
  #
  # Returns +obj+.
  #
  # @yield [obj] called if +self+ is truthy
  # @return [Object] +self+
  #
  # @example
  #   require 'mug/and-or'
  #
  #   try_thing.and_then {|result| log "got #{result.inspect}" }
  #
  def and_then &_block
    yield self if self
    self
  end

  #
  # Calls +block+ if +obj+ is falsey.
  #
  # Returns +obj+.
  #
  # @yield [obj] called if +self+ is falsey
  # @return [Object] +self+
  #
  # @example
  #   require 'mug/and-or'
  #
  #   try_thing.or_then { log "failed" }
  #
  def or_then &_block
    yield self unless self
    self
  end

end

=begin
Copyright (c) 2018-2026, Matthew Kerwin <matthew@kerwin.net.au>

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

# vim: set ts=2 sts=2 sw=2 expandtab:
