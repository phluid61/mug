class Proc
  # TruffleRuby's Proc#curry does not perform partial application for
  # non-lambda procs; it invokes the proc immediately regardless of the
  # number of arguments supplied.
  if RUBY_ENGINE == 'truffleruby'
    #
    # Curries this Proc and partially applies parameters.
    # If a sufficient number of arguments are supplied, it passes the
    # supplied arguments to the original proc and returns the result.
    # Otherwise, returns another curried proc that takes the rest of
    # arguments.
    #
    # @param args [Array] the arguments to partially apply
    # @return [Object, Proc] the result if sufficient args, or a curried Proc
    #
    def apply(*args)
      n = arity < 0 ? -arity - 1 : arity
      if lambda?
        curry(n).call(*args)
      elsif args.length >= n
        call(*args)
      else
        proc {|*more| call(*args, *more) }
      end
    end
  else
    #
    # Curries this Proc and partially applies parameters.
    # If a sufficient number of arguments are supplied, it passes the
    # supplied arguments to the original proc and returns the result.
    # Otherwise, returns another curried proc that takes the rest of
    # arguments.
    #
    # @param args [Array] the arguments to partially apply
    # @return [Object, Proc] the result if sufficient args, or a curried Proc
    #
    def apply(*args)
      n = arity < 0 ? -arity - 1 : arity
      curry(n).call(*args)
    end
  end
end

class Method
  #
  # Curries this Method and partially applies parameters.
  # If a sufficient number of arguments are supplied, it passes the
  # supplied arguments to the original proc and returns the result.
  # Otherwise, returns another curried proc that takes the rest of
  # arguments.
  #
  # @note +Method#curry+ is in stdlib since Ruby 2.2. +apply+ is shorthand
  #   for +curry.call(...)+.
  #
  # @param args [Array] the arguments to partially apply
  # @return [Object, Proc] the result if sufficient args, or a curried Proc
  #
  def apply(*args)
    n = arity < 0 ? -arity - 1 : arity
    curry(n).call(*args)
  end
end

=begin
Copyright (c) 2014-2026, Matthew Kerwin <matthew@kerwin.net.au>

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
