class DiceSet
  attr_reader :values
  def roll(n)
    @values = (1..n).to_a.sample(n)
  end
end