class Game
  attr_reader :players, :next_player
  attr_accessor :in_end_game
  @@round = 0

  def initialize(players)
    @players  	 = players
    @in_end_game = false
  end
  def last_round?
    players.any? { |player| player.total_points >= 600 }
  end
  def next_player
    player = @players[@@round % @players.count] # loop over players continually
    player.scoring_dice     = 0
    player.remaining_dice   = 5
    player.farkle           = false
    player.points           = 0
    @@round += 1
    return player
  end
  def winner
    players.max_by { |player| player.total_points }
  end
end
