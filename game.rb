class Game
  attr_reader :players, :winner, :round

  def initialize(players)
    @players  = players
    @round    = 0
  end
end