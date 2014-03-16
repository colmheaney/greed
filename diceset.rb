class DiceSet
	attr_reader :values	
	def roll(n)
		@values = (1..n).to_a.collect { |a| rand(6) + 1 }
	end
	# TODO: beef this up to highlight which dice are scoring
	def to_s
		string = ""
		@values.each { |d| string += "#{d} " }
		return string
	end
end