class Player
	attr_reader :name, :turn, :score
	@@turn = 0
	
	def initialize(name)
		@name   = name
		@score  = 0
		@turn   = @@turn += 1
	end
end