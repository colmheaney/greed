class Game
  attr_reader :players, :winner, :next_player
  @@round = 0

  def initialize(players)
    @players  	= players
    @winner     = ""
  end
  def is_won?
    players.any? { |player| player.points >= 3000 }
  end
  def next_player
    player = @players[@@round % @players.count]
    @@round += 1
    player.num_of_dice = 5
    return player
  end
  def self.round
    @@round
  end
end
