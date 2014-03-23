class Player
	attr_reader 	:name, :total_points, :id, :dice
	attr_accessor 	:remaining_dice, :scoring_dice, :farkle, :round_points
	MAX_DICE = 5
	@@id 	 = 0

	def initialize(name)
		@name			= name
	    @dice        	= DiceSet.new
		@total_points  	= 0
		@points 		= 0
 		@id 			= @@id += 1
	end
	def roll
		remaining_dice # can't seem to call method as a parameter so need to call it here
		@points = score(@dice.roll(remaining_dice)) 
	end	
	def bank(points)	
		@total_points += points
		@round_points = 0
	end
	def accum_points
		@round_points += @points
	end
	def remaining_dice
		if @scoring_dice == MAX_DICE
			@remaining_dice = MAX_DICE
			@scoring_dice = 0 # reset if player scores with all dice
		else
			@remaining_dice
		end
	end
	def to_json
	    {
	      :player         => @name,
	      :dice           => @dice.values,
	      :total_points   => @total_points,
	      :points         => @round_points,
	      :remaining_dice => @remaining_dice,
	      :scoring_dice   => @scoring_dice
	    }
	end

	private
	def score(num_of_dice)
		sum = 0
		num_of_dice.group_by { |i| i }.each do |key, value|
			if value.count >= 3
			  key == 1 ? sum += 1000 : sum += 100 * key
			  value.pop(3) # ditch triple values so they're not counted twice
			  @scoring_dice += 3
			end
			if key == 1; sum += value.count * 100; @scoring_dice += value.count end
			if key == 5; sum += value.count * 50;  @scoring_dice += value.count end
		end
		@remaining_dice = MAX_DICE - @scoring_dice
		return sum
	end
end