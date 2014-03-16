def getInput
	symbol = ""
	while symbol.empty?
		input = gets.chomp[0].downcase
		if input == 'r'
		 	symbol = :roll
		 	puts 'roll'
		elsif input == 'b'
			symbol = :bank
			puts 'bank'
		end
	end
end

getInput