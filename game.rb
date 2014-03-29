require 'em-websocket'

class Game
  attr_reader   :players, :next_player, :channel
  attr_accessor :last_round
  MAX_DICE = 6

  def initialize(players)
    @channel     = EM::Channel.new
    @players     = players
    @last_round  = false
    @won         = false
    @round       = 0
    @count       = 0
  end
  def won?
    if last_round and @count == players.count - 1
      return true
    elsif last_round and @count != players.count - 1
      @count += 1
      return false
    end
  end
  def next_player
    player = @players[@round % @players.count] # loop over players continually
    # reset everything
    player.remaining_dice   = MAX_DICE
    player.scoring_dice     = 0
    player.round_points     = 0
    player.farkle           = false
    @round += 1
    return player
  end
  # TODO: what to do in event of a tie?
  def winner
    players.max_by { |player| player.total_points }
  end
end
  