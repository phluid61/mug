
#
# Converts arg to a boolean (true or false).
#
def Bool(arg)
	!!arg
end

class Object
	#
	# Converts obj to a boolean.
	#
	def to_bool
		true
	end

	#
	# Converts obj to a boolean.
	#
	def to_b
		true
	end
end

def nil.to_bool; false; end
def nil.to_b; false; end
def false.to_bool; false; end
def false.to_b; false; end

class Numeric
	#
	# Converts num to a boolean.
	# Returns true if not zero.
	#
	def to_b
		self != 0
	end
end

class Float
	#
	# Converts num to a boolean.
	# Returns true if not zero or NaN.
	# Note: -0.0 is false, and +/-infinity are true.
	#
	def to_b
		!(self.zero? || self.nan?)
	end
end

class String
	#
	# Converts str to a boolean.
	# Returns true if not empty.
	#
	def to_b
		!empty?
	end
end

class Array
	#
	# Converts ary to a boolean.
	# Returns true if not empty.
	#
	def to_b
		!empty?
	end
end

class Hash
	#
	# Converts hsh to a boolean.
	# Returns true if not empty.
	#
	def to_b
		!empty?
	end
end

module Enumerable
	#
	# Converts enum to a boolean.
	# Returns true if there are any elements.
	#
	def to_b
		any?{ true }
	end
end

if RUBY_VERSION.to_i >= 2
class Enumerator
	#
	# Converts enum to a boolean.
	# Returns true if there are any elements.
	#
	def to_b
		size.to_b
	end
end
end

class Exception
	#
	# Converts ex to a boolean.
	# All Exceptions are considered false.
	#
	def to_b
		false
	end
end

