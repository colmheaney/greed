require './game.rb'
require './player.rb'
require './diceset.rb'
require './scoreboard.rb'

def getInput(player)
	puts "Your turn #{player.name}\nEnter command (r)oll, (b)ank?:"
	gets.downcase[0]
end
def putOutput(player, dice)
	puts "\n#{player.name}: #{player.points} points this round"
	puts "#{player.name}: #{player.total_points} total points\n\n"
	puts "Dice values on that throw: #{dice.values}"
	puts "#{player.num_of_dice} dice left to roll\n\n"
end

puts "Initializing game of Greed"
puts "=========================="
puts "How many players are there?\n"

players = []

gets.to_i.times do |n|
	puts 	"Name of player #{n+1}: "
	name 	= gets.chomp
	players << Player.new(name)
end

game = Game.new(players)
dice = DiceSet.new

puts "Game on!"
puts "========"

until game.last_round?
	player = game.next_player

	loop do
		input = getInput(player)

		if 	input == "r"
			throw_points = player.roll(dice)
		elsif input == "b"
			player.total_points += player.points
			break
		else
			redo
		end

		putOutput(player, dice)
		break if !player.in_game? || player.num_of_dice == 0 || throw_points == 0
	end
end

# puts "==========="
# puts "Last Round!"

# remaining_players = players.select { |player| player.total_points < 3000 }

# remaining_players.each do |player|
# 	player = game.next_player

# 	input = getInput(player)

# 	loop do
# 		if 	input == "r"
# 			throw_points = player.roll(dice)
# 		elsif input == "s"
# 			player.total_points += player.points
# 			break
# 		else
# 			redo
# 		end
# 		putOutput(player, dice)
# 		break if !player.in_game? || player.num_of_dice == 0 || throw_points == 0
# 	end
# end



