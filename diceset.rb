class DiceSet
	attr_reader :values	
	def roll(n)
		@values = (1..n).to_a.collect { |a| rand(6) + 1 }
	end
end