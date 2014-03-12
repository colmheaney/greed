require './game.rb'
require './player.rb'
require './diceset.rb'

def score(dice)
  sum = 0
  dice.group_by { |i| i }.each do |key, value|
    if value.count >= 3
      key == 1 ? sum += 1000 : sum += 100 * key
      value.pop(3)
    end
    if key == 1; sum += value.count * 100 end
    if key == 5; sum += value.count * 50  end
  end
  return sum
end
