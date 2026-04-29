
class Proc

  #
  # Applies this function to each element of +args+ in order.
  #
  def mapply *args
    args.map {|*a| self.call *a }
  end

  #
  # Generates a function that reorders its arguments according
  # to +indices+ and calls this function on the resulting
  # list.
  #
  def trans *indices
    lambda do |*a|
      n = [a.size, indices.size].min
      list = (0...n).map {|i| a[indices[i]] }
      self.call *list
    end
  end

  #
  # Generates a function that maps its arguments to each of
  # +funcs+ in order.
  #
  def lens *funcs
    lambda do |*a|
      n = [a.size, funcs.size].min
      funcs = (0...n).map do |i|
        if funcs[i].respond_to? :call
          funcs[i].call *a[i]
        else
          funcs[i]
        end
      end
      self.call funcs
    end
  end

end

