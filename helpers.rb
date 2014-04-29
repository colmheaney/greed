module Helpers

  def roll(player, game)
    player.roll
    if player.roll_points != 0
      player.accum_points
      game.channel.push JSON.generate(player.to_json)
    else
      player = game.next_player
      game.channel.push JSON.generate(player.to_json)
      check_won(game)
    end
  end
  def bank(player, game)
    if player.round_points >= 300 or player.roll_points >= 300
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
      player.score(message['get_points'])
      game.channel.push JSON.generate({:roll_points => player.roll_points})
  end
  def check_won(game)
    if game.won?
      game.channel.push game.winner.name + ' wins'
    end 
  end
end
