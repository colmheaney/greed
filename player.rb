class Player
	attr_reader :name
	attr_accessor :num_of_dice, :points, :total_points
	
	def initialize(name)
		@name   		= name
		@points  		= 0
		@total_points  	= 0
		@scoring_dice	= 0
	end
	def roll(dice)
		result = score(dice.roll(num_of_dice)) 
		if result == 0
			result
		elsif result >= 300 || self.in_game?
			@points += result
		end
	end	
	def in_game?
		@points >= 300
	end
	def num_of_dice
		@scoring_dice == 5 ? @num_of_dice = 5 : @num_of_dice = @num_of_dice - @scoring_dice
		@scoring_dice = 0
		return @num_of_dice
	end
	def bank(points)	
		if self.in_game?; @total_points += points; end
	end

	private
	def score(num_of_dice)
		sum, @scoring_dice = 0, 0
		num_of_dice.group_by { |i| i }.each do |key, value|
			if value.count >= 3
			  key == 1 ? sum += 1000 : sum += 100 * key
			  value.pop(3)
			  @scoring_dice += 3
			end
			if key == 1; sum += value.count * 100; @scoring_dice += value.count end
			if key == 5; sum += value.count * 50;  @scoring_dice += value.count end
		end
		return sum
	end
end