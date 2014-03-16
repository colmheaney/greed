class Player
	attr_reader :name, :total_points
	attr_accessor :remaining_dice, :scoring_dice, :farkle, :points
	
	def initialize(name)
		@name   		= name
		@total_points  	= 0
	end
	def roll(dice)
		score(dice.roll(remaining_dice)) 
	end	
	def bank(points)	
		@total_points += points
		@points = 0
	end
	def accum(points)
		@points += points
	end
	def remaining_dice
		if @scoring_dice == 5 
			@remaining_dice, @scoring_dice = 5, 0 # reset if player scores with all dice
		else
			@remaining_dice
		end
	end

	private
	def score(num_of_dice)
		sum = 0
		num_of_dice.group_by { |i| i }.each do |key, value|
			if value.count >= 3
			  key == 1 ? sum += 1000 : sum += 100 * key
			  value.pop(3) # ditch triple values so their not counted twice
			  @scoring_dice += 3
			end
			if key == 1; sum += value.count * 100; @scoring_dice += value.count end
			if key == 5; sum += value.count * 50;  @scoring_dice += value.count end
		end
		@remaining_dice = 5 - @scoring_dice
		return sum
	end
end