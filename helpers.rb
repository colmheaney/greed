module Helpers

  def roll(player, game)
    if player.roll != 0
      game.channel.push JSON.generate(player.to_json)
      player.accum_points
    else
      game.channel.push JSON.generate(player.to_json)
      player = game.next_player
      check_won(game)
    end
  end
  def bank(player, game)
    if player.round_points >= 300
      player.bank(player.round_points)
      game.channel.push JSON.generate(player.to_json)
      if player.total_points >= 600
        game.last_round = true
      end
      player = game.next_player
      check_won(game)
    end
  end
  def check_points(message, player, game)
      $log.debug(player.score(message['check_points']))
      game.channel.push JSON.generate(player.to_json)
  end
  def check_won(game)
    if game.won?
      game.channel.push game.winner.name + ' wins'
    end 
  end
end
