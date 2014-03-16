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
	
	num_players = gets.chomp.to_i 
	
	num_players.times do |n|
		clear
		puts "Player #{n+1} name: "
		players << Player.new(gets.chomp)
	end
	players

end
def getInput(player, dice)
	symbol = ""
	while symbol.empty?
		clear

		puts "Your turn #{player.name}, (r)oll (b)ank: "
		puts "Dice values: #{dice.to_s}" unless dice.values.nil?
		puts "Scoring dice: #{player.scoring_dice}"
		puts "Remaining dice: #{player.remaining_dice}"
		puts "Points this round: #{player.points}"
		puts "Points banked: #{player.total_points}"
			
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
# setup the diceset
dice = DiceSet.new
count = 0

# accept input until game is won
while true
	player = game.next_player

	until player.farkle
		input = getInput(player, dice)
		if input == :roll
			points = player.roll(dice)
			if points != 0
				# add points for the current round
				player.accum(points)
			else
				# if player doesn't achieve a score, they have farkeld
				player.farkle = true
			end
		# player can't bank unless they have accumulated over 300 points this round	
		elsif input == :bank and player.points >= 300
			player.bank(player.points)
			break # next player
		end
	end
	# if last round then cycle through the remaining players one more time
	if game.in_end_game
		count += 1
		if count == game.players.count - 1
			break # end game
		end
	end
	# flag set to true if a player achieves over 3000
	if game.last_round?
		game.in_end_game = true
	end
end

message("Game over. #{game.winner.name} wins!")
