
module Kernel
  #
  # Repeatedly executes the block, yielding the current iteration
  # count, which starts from +offset+. If no block is given, returns
  # a new Enumerator that includes the iteration count, starting
  # from +offset+
  #
  def loop_with_index(offset=0)
    return c=enum_for(:loop_with_index, offset) unless block_given?
    c = 0 + offset
    while true
      yield c
      c += 1
    end
  rescue StopIteration
  ensure
    return c
  end

  #
  # Repeatedly executes the block, yielding an arbitrary object, +obj+.
  #
  def loop_with_object(obj)
    return obj=enum_for(:loop_with_object, obj) unless block_given?
    while true
      yield obj
    end
  rescue StopIteration
  ensure
    return obj
  end
end

