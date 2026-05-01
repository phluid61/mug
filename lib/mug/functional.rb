
class Proc

  #
  # Composes a sequence of functions.
  #
  # A function is anything that responds to #to_proc, so
  # symbols are allowed.
  #
  # This proc is prepended at the start of the composition.
  #
  def compose *funcs
    return self if funcs.empty?
    self >> funcs.map(&:to_proc).reduce(:>>)
  end

  #
  # Composes a sequence of functions.
  #
  # A function is anything that responds to #to_proc, so
  # symbols are allowed.
  #
  # This proc is appended at the end of the composition.
  #
  def precompose *funcs
    return self if funcs.empty?
    self << funcs.map(&:to_proc).reduce(:>>)
  end

  #
  # Applies this function to each element of +args+ in order.
  #
  # `proc.mapply(*args)` is equivalent to `args.map(&proc)`
  #
  def mapply *args
    args.map {|*a| self.call(*a) }
  end

  #
  # Generates a function that memoizes this one. For a given
  # set of parameters, this proc is only invoked once; the
  # result is remembered for subsequent invocations.
  #
  def memoize
    cache = {}
    lambda do |*args|
      cache.fetch(args) {|_| cache[args] = self.call(*args) }
    end
  end
  alias memoise memoize

  #
  # Generates a function that reorders its arguments according
  # to +indices+ and calls this function on the resulting
  # list.
  #
  # The +arity+ parameter controls how mismatches in length
  # between the arguments and indices are handled:
  #   :min       - cap at the minimum of args and indices (default)
  #   :max       - use the maximum; nil-fill if args are short,
  #                pass-through if args are long
  #   :indices   - always use indices.size; nil for out-of-bounds
  #   :arguments - always use args.size; excess positions pass
  #                through at their original index
  #
  def trans *indices, arity: :min
    case arity
    when :min
      lambda do |*a|
        n = [a.size, indices.size].min
        list = (0...n).map {|i| a[indices[i]] }
        self.call(*list)
      end
    when :indices
      lambda do |*a|
        list = (0...indices.size).map {|i| a[indices[i]] }
        self.call(*list)
      end
    when :arguments
      lambda do |*a|
        list = (0...a.size).map do |i|
          i < indices.size ? a[indices[i]] : a[i]
        end
        self.call(*list)
      end
    when :max
      lambda do |*a|
        n = [a.size, indices.size].max
        list = (0...n).map do |i|
          i < indices.size ? a[indices[i]] : a[i]
        end
        self.call(*list)
      end
    else
      raise ArgumentError, "unknown arity mode: #{arity.inspect}"
    end
  end

  #
  # Generates a function that maps its arguments to each of
  # +funcs+ in order.
  #
  def zipmap *funcs
    lambda do |*args|
      n = [args.size, funcs.size].min
      mapped = (0...n).map do |i|
        func = funcs[i]
        arg  = args[i]

        if func.nil?
          arg
        elsif func.respond_to? :call
          func.call arg
        elsif func.is_a?(Symbol) && arg.respond_to?(func)
          arg.__send__ func
        else
          raise TypeError, "expected callable, Symbol, or nil; got #{func.class}"
        end
      end
      self.call(*mapped)
    end
  end

  class << self

    #
    # Generates a function that maps its arguments to the
    # given +funcs+ list in order.
    #
    def juxt *funcs
      lambda do |*args|
        funcs.map {|f| f.to_proc.call(*args) }
      end
    end

    #
    # Generates an identity function that always returns its argument exactly.
    #
    def identity
      lambda {|x| x }
    end

    #
    # Generates a constant function that always returns +c+.
    #
    # Note that it always returns the same object, so mutations will stick
    # from invocation to invocation.
    #
    def const c
      lambda {|*| c }
    end

  end
end

class Enumerator
  class << self

    #
    # Creates an Enumerator that can unfold a sequence from a given seed.
    #
    def unfold(seed, &blk)
      raise ArgumentError, 'no block given' unless block_given?
      Enumerator.new do |y|
        loop do
          result = blk.call(seed)
          break if result.nil?
          value, seed = result
          y << value
        end
      end
    end

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
