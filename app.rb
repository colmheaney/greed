require './init.rb'

EventMachine.run do
  class App < Sinatra::Base

      get '/' do
          erb :index
      end
  end

  
  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws|
      ws.onopen {

        p1      = Player.new('colm')
        p3      = Player.new('paul')
        p2      = Player.new('greedbot')
        game    = Game.new([p1,p2,p3])
        player  = game.next_player

        game.channel.subscribe { |msg| ws.send msg }

        ws.onmessage { |msg|

          message = JSON.parse(msg)

            if message['msg'] == 'roll'
              if player.roll != 0
                game.channel.push JSON.generate(player.to_json)
                player.accum_points
              else
                game.channel.push JSON.generate(player.to_json)
                player = game.next_player
                if game.won?
                  game.channel.push game.winner.name + ' wins'
                end
              end
            end
            if message['msg'] == 'bank' and player.round_points >= 300
              player.bank(player.round_points)
              game.channel.push JSON.generate(player.to_json)
              if player.total_points >= 600
                game.last_round = true
              end
              player = game.next_player
              if game.won?
                game.channel.push game.winner.name + ' wins'
              end
            end
            if message.include?('get_points')
              $log.debug player.score(message['get_points'])
            end
        }

        ws.onclose {
          $channel.unsubscribe(sid)
        }
      }

  end

  App.run!({:port => 3000})
end