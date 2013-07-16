
#
# Invokes a method chain until one method returns a falsy value.
#
# For example:
#
#     a._?.b.c.d._!
#     nested_hash._?[:a][:b][:c]._!
#
class FragileMethodChain
	#
	# Creates a FragileMethodChain which will send its first method to +o+
	#
	def initialize o
		@o = o
		@chain = []
	end

	#
	# Finalises the FragileMethodChain.
	#
	# The final result will be the first +nil+ or +false+ value
	# returned in the chain, or its end result.
	#
	def _!
		@chain.inject(@o) do |o,x|
			a,b = x
			break o unless o
			o.__send__(*a, &b)
		end
	end

	# Record the method args/block
	def method_missing *a, &b #:nodoc:
		@chain << [a,b]
		self
	end

	# Explicitly record :_? as a method in the chain.
	def _? #:nodoc:
		@chain << [[ :_? ],nil]
		self
	end
end

class Object
	#
	# Begins a FragileMethodChain.
	#
	def _?
		FragileMethodChain.new(self)
	end
end
