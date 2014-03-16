class Game
  attr_reader :players, :winner, :next_player
  @@round = 0

  def initialize(players)
    @players  	= players
    @winner     = ""
  end
  def last_round?
    players.any? { |player| player.points >= 3000 }
  end
  def next_player
    player = @players[@@round % @players.count]
    player.num_of_dice = 5
    player.points = 0
    @@round += 1
    return player
  end
  def self.round
    @@round
  end
end
