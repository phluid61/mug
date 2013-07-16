
class Object
	#
	# Returns this object.
	#
	# If a block is given, this object is yielded to it, and the result
	# is returned.
	#
	def self(&block)
		if block_given?
			yield self
		else
			self
		end
	end
end
