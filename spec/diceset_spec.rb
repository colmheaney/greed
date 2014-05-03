require 'spec_helper'

describe DiceSet  do
  before :each do
    @dice = DiceSet.new
  end
  describe "#roll" do
    it "should respond to roll and values" do
      @dice.should respond_to :roll, :values 
    end
    it "should return an array" do
      @dice.roll(6).should be_instance_of Array       
    end
    it "should return a random array of numbers" do
      @dice.roll(6).should_not eql @dice.roll(6) 
    end
  end  
  describe "#scoring_dice" do
    it "should return an array of 2 arrays" do
      @dice.scoring_dice.should be_instance_of Array
      @dice.scoring_dice.should have(2).items
      @dice.scoring_dice[0].should be_instance_of Array
      @dice.scoring_dice[1].should be_instance_of Array
    end
    it "should separate non scoring dice and scoring dice" do
      dice = @dice.scoring_dice([1,2,3,1,2,3])
      dice[0].should include(1)
      dice[0].should_not include(2,3)

      dice = @dice.scoring_dice([2,2,2,3,3])
      dice[0].should include(2)
      dice[0].should_not include(3)
      dice[1].should include(3)
    end
  end
end
