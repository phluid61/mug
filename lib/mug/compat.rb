
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
  class Array
    alias append push
    alias prepend unshift
  end

  class Exception
    def __summary highlight
      if highlight
        if message.nil? || message.empty?
          "\e[1;4munhandled exception\e[0m"
        else
          "\e[1m#{message} (\e[4m#{self.class.name}\e[24m)\e[0m"
        end
      else
        if message.nil? || message.empty?
          "unhandled exception"
        else
          "#{message} (#{self.class.name})"
        end
      end
    end

    def __full_message_bottom highlight
      bt = backtrace.dup
      main_line = bt.shift + ': ' + __summary(highlight)

      length = Math.log10(bt.length+1).ceil
      ary = bt.each_with_index.reverse_each.map{|line, i| "\t%#{length}d: from %s" % [i+1, line] }
      if respond_to?(:cause) && cause
        ary = cause.__full_message_bottom(highlight) + ary
      end
      ary.push main_line
      ary
    end

    def __full_message_top highlight
      bt = backtrace.dup
      main_line = bt.shift + ': ' + __summary(highlight)

      ary = bt.map{|line| "\tfrom #{line}" }
      ary.unshift main_line
      if respond_to?(:cause) && cause
        ary += cause.__full_message_top(highlight)
      end
      ary
    end

    ##
    # Returns formatted string of exception. The returned string is formatted using the same format that Ruby uses when printing an uncaught exceptions to stderr.
    #
    # If highlight is true the default error handler will send the messages to a tty.
    #
    # order must be either of :top or :bottom, and places the error message and the innermost backtrace come at the top or the bottom.
    #
    # The default values of these options depend on $stderr and its tty? at the timing of a call.
    #
    def full_message highlight: true, order: :bottom
      case order
      when :top
        ary = __full_message_top(highlight)
        ary
      when :bottom
        if highlight
          bottom_header = "\e[1mTraceback\e[0m"
        else
          bottom_header = "Traceback"
        end
        ary = __full_message_bottom(highlight)
        ary.unshift "#{bottom_header} (most recent call last):"
        ary
      else
        raise ArgumentError, "expected :top or :bottom as order: #{order.inspect}"
      end
    end
  end

  class <<Dir
    ##
    # Calls the block once for each entry except for “.” and “..” in the named directory, passing the filename of each entry as a parameter to the block.
    #
    # If no block is given, an enumerator is returned instead.
    #
    def each_child dirname, **encoding
      return enum_for(:each_child, dirname, **encoding) unless block_given?
      open(dirname, **encoding) do |dh|
        dh.each do |child|
          yield child unless child == '.' || child == '..'
        end
      end
    end

    ##
    # Returns an array containing all of the filenames except for “.” and “..” in the given directory. Will raise a +SystemCallError+ if the named directory doesn't exist.
    #
    # The optional _encoding_ keyword argument specifies the encoding of the directory. If not specified, the filesystem encoding is used.
    #
    def children dirname, **encoding
      each_child(dirname, **encoding).to_a
    end
  end

  # TODO: File.lutime ??

  class Hash
    ##
    # Returns a hash containing only the given keys and their values.
    def slice *keys
      keys.each_with_object({}) do |key, hsh|
        next unless key? key
        hsh[key] = self[key]
      end
    end
  end

  # TODO: IO#pread, #pwrite

  class Integer
    ##
    # Returns +true+ if all bits of +int & mask+ are +1+.
    def allbits? mask
      (self & mask) == mask
    end

    ##
    # Returns +true+ if any bits of +int & mask+ are +1+.
    def anybits? mask
      (self & mask) != 0
    end

    ##
    # Returns +true+ if no bits of +int & mask+ are +1+.
    def nobits? mask
      (self & mask) == 0
    end
  end

  class <<Integer
    ##
    # Returns the integer square root of the non-negative integer +n+, i.e. the largest non-negative integer less than or equal to the square root of +n+.
    #
    # Equivalent to +Math.sqrt(n).floor+, except that the result of the latter code may differ from the true value due to the limited precision of floating point arithmetic.
    #
    # If +n+ is not an Integer, it is converted to an Integer first. If +n+ is negative, a Math::DomainError is raised.
    #
    def sqrt n
      n = n.to_i
      raise Math::DomainError if n < 0
      Math.sqrt(n).floor
    end
  end

  class Method
    ##
    # Invokes the block with +obj+ as the proc's parameter like Proc#call. It is
    # to allow a proc object to be a target of +when+ clause in a case statement.
    def === obj
      call(obj)
    end
  end

  class <<Process
    ##
    # Returns the status of the last executed child process in the current thread.
    #
    # If no child process has ever been executed in the current thread, this returns +nil+.
    #
    def last_status
      $?
    end
  end

  class String
    alias __old_casecmp casecmp
    def casecmp other_str
      return unless other_str.respond_to? :to_str
      __old_casecmp other_str
    end

    alias __old_casecmp? casecmp?
    def casecmp? other_str
      return unless other_str.respond_to? :to_str
      __old_casecmp? other_str
    end

    ##
    # Returns a copy of _str_ with leading +prefix+ deleted.
    def delete_prefix prefix
      return dup unless start_with? prefix
      return dup if prefix.empty?
      self[prefix.length..-1]
    end

    ##
    # Deletes leading +prefix+ from _str_, returning +nil+ if no change was made.
    def delete_prefix! prefix
      return unless start_with? prefix
      return if prefix.empty?
      self[0...prefix.length] = ''
      self
    end
  end

  # TODO: String#each_grapheme_cluster, #grapheme_clusters
  # TODO: String#undump

  class Thread
    def fetch sym, *default
      raise ArgumentError if default.length > 1
      return self[sym] if key? sym
      return default.first if default.length > 0
      return yield(sym) if block_given?
      raise KeyError
    end
  end
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

