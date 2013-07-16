
#
# Invokes methods on a wrapped object, if that object is truthy.
#
class MaybeDelegator
	#
	# Creates a new MaybeDelegator, wrapping +o+
	#
	def initialize o
		@o = o
	end

	#
	# Returns this MaybeDelegator object.
	#
	def maybe
		self
	end

	# Calls the method on +@o+ if it's truthy.
	def method_missing *a, &b #:nodoc:
		@o && @o.send(*a, &b)
	end
end

class Object
	#
	# Do something if this object is truthy.
	#
	# If a block is given, it is executed in the context of this
	# object, iff this object is neither +nil+ nor +false+.
	#
	# If no block is given, returns a MaybeDelegator object.
	#
	def maybe &b
		if b
			self && instance_eval(&b)
		else
			MaybeDelegator.new(self)
		end
	end
end
