
require_relative '../iterator'

class Object
	#
	# Creates a new Iterator for the method named +meth+
	#
	def iter_for meth, *args
		Iterator.new self, meth, *args
	end
	alias :to_iter :iter_for
end
