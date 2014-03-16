class Game
  attr_reader :players, :next_player
  attr_accessor :in_end_game
  THRESHOLD_SCORE = 3000
  MAX_DICE        = 5
  @@round         = 0

  def initialize(players)
    @players  	 = players
    @in_end_game = false
  end
  def last_round?
    players.any? { |player| player.total_points >= THRESHOLD_SCORE }
  end
  def next_player
    player = @players[@@round % @players.count] # loop over players continually
    # reset everything
    player.scoring_dice     = 0
    player.remaining_dice   = MAX_DICE
    player.farkle           = false
    player.points           = 0
    @@round += 1
    return player
  end
  def winner
    players.max_by { |player| player.total_points }
  end
end
