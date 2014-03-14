class Player
	attr_reader :name, :points
	attr_accessor :num_of_dice
	
	def initialize(name)
		@name   		= name
		@points  		= 0
		@num_of_dice 	= 5
	end
	def roll_dice(diceset)
		result = score(diceset.roll(@num_of_dice)) 
		if result >= 300 || self.in_game?
			@points += result
		end
		return @points
	end	
	def in_game?
		@points >= 300
	end

	private
	def score(num_of_dice)
		sum, @num_of_dice = 0, 0
		num_of_dice.group_by { |i| i }.each do |key, value|
			if value.count >= 3
			  key == 1 ? sum += 1000 : sum += 100 * key
			  value.pop(3)
			  @num_of_dice += 3
			end
			if key == 1; sum += value.count * 100; @num_of_dice += value.count end
			if key == 5; sum += value.count * 50;  @num_of_dice += value.count end
		end
		return sum
	end
end