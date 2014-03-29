require './init.rb'

EventMachine.run do
  include Helpers

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

        sid = game.channel.subscribe { |msg| ws.send msg }

        ws.onmessage { |msg|

          message = JSON.parse(msg)

            if message['msg'] == 'roll'
              Helpers::roll(player, game)
            elsif message['msg'] == 'bank'
              Helpers::bank(player, game)
            elsif message.include?('check_points')
              Helpers::check_points(message, player, game)              
            end
        }

        ws.onclose {
          $channel.unsubscribe(sid)
        }
      }

  end

  App.run!({:port => 3000})
end