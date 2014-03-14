require './game.rb'
require './player.rb'
require './diceset.rb'
require './scoreboard.rb'

def getInput(player)
	puts "Your turn #{player.name}\nEnter command (r)oll, (s)tick?:"
	command = gets
end
def putOutput(player, dice)
	puts "#{player.name}: #{player.points} points\n\n"
	puts "Dice values on that throw: #{dice.values}"
	puts "#{player.num_of_dice} scoring dice"
end

puts "Initializing game of Greed"
puts "=========================="
puts "How many players are there?\n"

num_players = gets.to_i
players 	= []

num_players.times do |n|
	puts 	"Name of player #{n+1}: "
	name 	= gets.chomp
	players << Player.new(name)
end

game 	= Game.new(players)
dice 	= DiceSet.new

puts "Game on!"
puts "========"

until game.is_won?
	player = game.next_player

	loop do
		input = getInput(player)
		player.roll_dice(dice)
		putOutput(player, dice)
		break if player.num_of_dice == 0 || !player.in_game?
	end
end

puts "===="
puts "ftw!"

