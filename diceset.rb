class DiceSet
	attr_reader :values	
	def roll(n)
		@values = (1..n).to_a.collect { |a| rand(6) + 1 }
	end
	def scoring_dice(values=@values)
		values ||= []
		scoring, nonscoring, array = [], [], []
		values.group_by { |a| a }.each do |k,v|
			case 
			when k == 1      		then scoring << v
			when k == 5 	    	then scoring << v
			when v.count == 3 	then scoring << v
			when v.count == 4 	then scoring << v
			when v.count == 5 	then scoring << [k]*4; nonscoring << k
			when v.count == 6 	then scoring << v
			else 				             nonscoring << v
			end
		end
		array = scoring.flatten, nonscoring.flatten
	end
end
