require './game.rb'
require './player.rb'
require './diceset.rb'
require './scoreboard.rb'

def clear
	puts "\033[2J"
	puts "\033[1;1H"
end
def message(string)
	clear
	puts "="*string.length
	puts string
	puts "="*string.length
end
def getPlayers
	players = []
	puts "How many players are there: "
	
	gets.chomp.to_i.times do |n|
		clear
		puts "Player #{n+1} name: "
		players << Player.new(gets.chomp)
	end
	players
end
def getInput(player)
	symbol = ""
	while symbol.empty?
		clear

		puts "Your turn #{player.name}, (r)oll (b)ank: "
		puts "Dice values: #{player.dice.to_s}" unless player.dice.values.nil?
		puts "Scoring dice: #{player.scoring_dice}"
		puts "Remaining dice: #{player.remaining_dice}"
		puts "Points this round: #{player.round_points}"
		puts "Points banked: #{player.total_points}"
		puts player.id
			
		case gets.chomp[0].downcase 
		when 'r' then symbol = :roll
		when 'b' then symbol = :bank
		else redo
		end
	end
	return symbol
end

# greet the players
message("Initializing game of Greed")
# setup the game
game = Game.new(getPlayers)

# accept input until game is won
until game.won?
	player = game.next_player

	until player.farkle
		input = getInput(player)
		if input == :roll
			points = player.roll
			if points != 0
				# add points for the current round
				player.accum_points
			else
				# if player doesn't achieve a score, they have farkeld
				player.farkle = true
			end
		# player can't bank unless they have accumulated over 300 points this round	
		elsif input == :bank and player.round_points >= 300
			player.bank(player.round_points)
			if player.total_points >= 600
				game.last_round = true
			end
			break # next player
		end
	end
end

message("Game over. #{game.winner.name} wins!")
