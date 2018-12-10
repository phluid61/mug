
if RUBY_VERSION < '2.4'
  class <<Dir
    ##
    # Returns +true+ if the named file is an empty directory, false if it is not a directory or non-empty.
    def empty? path_name
      entries(path_name).reject('.').reject('..').empty? rescue false
    end
  end

  module Comparable
    ##
    # Returns +min+ if +obj+ <=> +min+ is less than zero, +max+ if +obj+ <=> +max+ is greater than zero and +obj+ otherwise.
    def clamp min, max
      raise ArgumentError, "min argument must be smaller than max argument" if (min <=> max) > 0
      c = (self <=> min)
      return self if c == 0
      return min if c < 0
      c = (self <=> max)
      return max if c > 0
      self
    end
  end

  module Enumerable
    ##
    # Returns the sum of elements in an Enumerable.
    #
    # If a block is given, the block is applied to each element before addition.
    #
    # If +enum+ is empty, it returns +init+.
    #
    def sum init=0
      if block_given?
        each{|v| init += yield(v) }
      else
        each{|v| init += v }
      end
      init
    end

    ##
    # Returns a new array by removing duplicate values in +self+.
    #
    # See also Array#uniq.
    #
    def uniq
      hsh = {}
      if block_given?
        each{|v| hsh[yield(v)] = 1 }
      else
        each{|v| hsh[v] = 1 }
      end
      hsh.keys
    end
  end

  # TODO: Enumerator::Lazy#chunk_while
  # TODO: Enumerator::Lazy#uniq

  class <<File
    alias_method :empty?, :zero?
  end

  class Hash
    ##
    # Returns a new hash with the nil values/key pairs removed
    def compact
      hsh = {}
      each do |k, v|
        hsh[k] = v unless v.nil?
      end
      hsh
    end

    ##
    # Removes all nil values from the hash. Returns nil if no changes were made, otherwise returns the hash.
    def compact!
      hsh = {}
      any = false
      each do |k, v|
        if v.nil?
          any = true
        else
          hsh[k] = v
        end
      end
      return unless any
      replace hsh
      self
    end

    ##
    # Returns a new hash with the results of running the block once for every value. This method does not change the keys.
    #
    # If no block is given, an enumerator is returned instead.If no block is given, an enumerator is returned instead.
    #
    def transform_values
      return enum_for(:transform_values) unless block_given?
      hsh = {}
      each do |k, v|
        hsh[k] = yield v
      end
      hsh
    end

    ##
    # Invokes the given block once for each value in hsh, replacing it with the new value returned by the block, and then returns hsh. This method does not change the keys.
    #
    # If no block is given, an enumerator is returned instead.
    #
    def transform_values!
      return enum_for(:transform_values!) unless block_given?
      replace( transform_values{|v| yield v } )
      self
    end
  end

  class String
    ##
    # Returns +true+ if +str+ and +other_str+ are equal after Unicode case folding, +false+ if they are not equal.
    #
    # +nil+ is returned if the two strings have incompatible encodings, or if +other_str+ is not a string.
    #
    def casecmp? other_str
      return unless other_str.respond_to? :to_str
      result = casecmp(other_str)
      return unless result
      result == 0
    end

    ##
    # Converts _pattern_ to a Regexp (if it isn't already one), then returns a +true+ or +false+ indicates
    # whether the regexp is matched _str_ or not ~~without updating +$~+ and other related variables.~~ If
    # the second parameter is present, it specifies the position in the string to begin the search.
    #
    def match? pattern, *pos
      raise "wrong number of arguments (#{args.length} for 1..2)" if pos.length > 1
      match(pattern, *pos) ? true : false
    end

    ##
    # Decodes _str_ (which may contain binary data) according to the format string, returning the first value extracted. See also String#unpack, Array#pack.
    def unpack1 format
      unpack(format).first
    end
  end

  class Symbol
    def casecmp? other_symbol
      return unless other_symbol.is_a? Symbol
      to_s.casecmp? other_symbol.to_s
    end

    def match? pattern, *pos
      to_s.match? pattern, *pos
    end
  end

  # TODO: Thread.report_on_exception ??

  module Warning
    def warn msg
      warn msg
      nil
    end
  end
end

if RUBY_VERSION < '2.5'
  # TODO: Array#append, #prepend
  # TODO: Exception#full_message
  # TODO: Dir.children, Dir.each_child
  # TODO: File.lutime ??
  # TODO: Hash#transform_keys/!
  # TODO: Hash#slice
  # TODO: IO#pread, #pwrite
  # TODO: Integer#allbits?, #anybits?, #nobits?
  # TODO: Integer.sqrt
  # TODO: Method#=== <= #call
  # TODO: Process.last_status <= $?
  # TODO: String#casecmp return nil for non-string args
  # TODO: String#delete_prefix/!, #delete_suffix/!
  # TODO: String#each_grapheme_cluster, #grapheme_clusters
  # TODO: String#undump
  # TODO: Thread#fetch ?
end

if RUBY_VERSION < '2.6'
  module Kernel
    if RUBY_VERSION < '2.5'
      ##
      # Yields self to the block and returns the result of the block.
      def yield_self
        return enum_for(:yield_self) { 1 } unless block_given?
        yield self
      end
    end
    alias_method :then, :yield_self
  end
end

