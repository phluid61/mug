
class Module

  # Makes +new_name+ a new copy of the singleton method +old_name+.
  # This can be used to retain access to singleton methods that are
  # overridden.
  #
  # @param new_name [Symbol] the name for the new alias
  # @param old_name [Symbol] the name of the existing method
  # @return [self]
  #
  # @example
  #   require 'mug/alias'
  #
  #   module Mod
  #     def self.foo
  #       1
  #     end
  #     alias_singleton_method :bar, :foo
  #     def self.foo
  #       2
  #     end
  #   end
  #   Mod.foo #=> 2
  #   Mod.bar #=> 1
  #
  def alias_singleton_method new_name, old_name
    singleton_class.class_exec { alias_method new_name, old_name }
    self
  end
  private :alias_singleton_method

end

=begin
Copyright (c) 2017-2026, Matthew Kerwin <matthew@kerwin.net.au>

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
