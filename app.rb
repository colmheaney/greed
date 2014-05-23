require './init.rb'

EventMachine.run do

  class App < Sinatra::Base

      get '/' do
        erb :index
      end
      post '/game' do
        $player1 = params[:player1].to_s
        $player2 = params[:player2].to_s
        erb :game
      end
  end

  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws|
      ws.onopen {

        game = Game.new([Player.new($player1), Player.new($player2)])
        player = game.next_player

        sid = game.channel.subscribe { |msg| ws.send msg; $log.debug msg }

        ws.onmessage { |msg|

          message = JSON.parse(msg)

          if message['msg'] == 'roll' and (player.roll_points != 0 and not player.first_roll) or (player.roll_points == 0 and player.first_roll)
            player.roll
            player.first_roll = false
            if player.dice.scoring_dice[0].empty?
              game.channel.push JSON.generate(player.to_json)
              player = game.next_player
              check_won(game)
            else
              player.accum_points
              game.channel.push JSON.generate(player.to_json)
            end

          elsif message['msg'] == 'bank'
            if player.round_points + player.roll_points >= 300
              player.accum_points
              player.bank
              game.channel.push JSON.generate(player.to_json)
              if player.total_points >= 600
                game.last_round = true
              end
              player = game.next_player
              check_won(game)
            end

          elsif message.include?('get_points')
            player.score(message['get_points'])
            game.channel.push JSON.generate({:roll_points => player.roll_points})            
          end

          def check_won(game)
            if game.won?
              game.channel.push Player.winner(game).name + ' wins'
            end 
          end
        }

        ws.onclose {
          $channel.unsubscribe(sid)
        }
      }

  end

  App.run!({:port => 3000})
end
