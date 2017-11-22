
module Kernel
  #
  # Repeatedly executes the block, yielding the current iteration
  # count, which starts from +offset+. If no block is given, returns
  # an Enumerator.
  #
  def loop_with_index(offset=0)
    return enum_for(:loop_with_index, offset) unless block_given?
    c = 0 + offset
    begin
      while true
        yield c
        c += 1
      end
    rescue StopIteration
    end
    c
  end

  #
  # Repeatedly executes the block, yielding an arbitrary object, +obj+.
  #
  def loop_with_object(obj)
    return obj=enum_for(:loop_with_object, obj) unless block_given?
    begin
      while true
        yield obj
      end
    rescue StopIteration
    end
    obj
  end
end

