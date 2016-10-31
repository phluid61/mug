
module Enumerable

  #
  # Returns a hash of item=>count showing how many
  # of each +item+ are in this Enumerable.
  #
  def counts &block
    return counts_by(&block) if block_given?
    hsh = Hash.new{|h,k| h[k] = 0 }
    each do |k|
      hsh[k] += 1
    end
    hsh
  end

  #
  # Passes each element in turn to the block, and returns a
  # hash of result=>count.
  #
  # If no block is given, an enumerator is returned.
  #
  def counts_by &block
    return enum_for(:counts_by) unless block_given?
    hsh = Hash.new{|h,k| h[k] = 0 }
    each do |j|
      k = yield j
      hsh[k] += 1
    end
    hsh
  end

end

