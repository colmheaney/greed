class Player
	attr_reader 	  :name, :total_points, :id, :dice
	attr_accessor 	:remaining_dice, :scoring_dice, :round_points, :roll_points, :first_roll
	MAX_DICE = 6
	@@id 	 = 0

	def initialize(name)
    @dice           	= DiceSet.new
    @name	    		    = name
    @id 			        = @@id += 1
    @remaining_dice   = MAX_DICE
    @scoring_dice     = 0
    @total_points     = 0
    @round_points     = 0
    @roll_points      = 0
    @first_roll       = true
	end
	def roll
		dice = remaining_dice 
		@dice.roll(dice)
	end	
	def bank
		@total_points += @round_points
		@round_points = 0
	end
	def accum_points
		@round_points += @roll_points
		@roll_points = 0
  end
	def remaining_dice
		@remaining_dice = @remaining_dice - @scoring_dice
		if @remaining_dice == 0
			@remaining_dice = MAX_DICE
		end
		@remaining_dice
	end
	def to_json
	    {
	      :player         => @name,
	      :dice           => @dice.scoring_dice,
	      :dice_values	  => @dice.values,
	      :total_points   => @total_points,
	      :round_points   => @round_points,
	      :roll_points    => @roll_points,
	      :remaining_dice => @remaining_dice,
	      :scoring_dice   => @scoring_dice
	    }
	end
	def score(dice)
		@roll_points, @scoring_dice = 0, 0
		dice.group_by { |i| i }.each do |key, value|
			if value.count >= 3
			  key == 1 ? @roll_points += 1000 : @roll_points += 100 * key
			  value.pop(3) # ditch triple values so they're not counted twice
			  @scoring_dice += 3
			end
			if key == 1; @roll_points += value.count * 100; @scoring_dice += value.count end
			if key == 5; @roll_points += value.count * 50;  @scoring_dice += value.count end
		end
		return @roll_points
	end
  def self.winner(game)
    game.players.max_by { |player| player.total_points }
  end
end
