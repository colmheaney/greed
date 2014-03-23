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

            if msg == 'roll'
              if player.roll != 0
                player.accum_points
              else
                player = game.next_player
                if game.won?
                  game.channel.push game.winner.name + ' wins'
                end
              end
            elsif msg == 'bank' and player.round_points >= 300
              player.bank(player.round_points)
              if player.total_points >= 600
                game.last_round = true
              end
              player = game.next_player
              if game.won?
                game.channel.push game.winner.name + ' wins'
              end
            end
            game.channel.push JSON.generate(player.to_json)
        }

        ws.onclose {
          $channel.unsubscribe(sid)
        }
      }

  end

  App.run!({:port => 3000})
end