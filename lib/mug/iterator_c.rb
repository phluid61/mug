
#
# A special class of Enumerator that repeatedly invokes a method.
#
# Initially the method is send to the given +obj+, but subsequent
# invocations are sent to the result of the previous invocation.
#
# Example:
#
#     0.iter_for(:next).take(5) #=> [0,1,2,3,4]
#
class Iterator < Enumerator
	#
	# Creates a new Iterator for method +meth+, to be
	# called initially on object +obj+.
	#
	# All method calls will have +args+ as parameters.
	#
	def initialize obj, meth, *args
		super() do |y|
			loop do
				y << obj
				obj = obj.send(meth, *args)
			end
		end
	end
end
