
require_relative '../iterator_c'

class Method
	#
	# Creates a new Iterator for this method, initially invoked
	# on this method's receiver.
	#
	def to_iter *args
		Iterator.new receiver, name, *args
	end
end
