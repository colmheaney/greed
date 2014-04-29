require 'spec_helper'

describe Game do
  before :each do
    @players = [Player.new('P1'), Player.new('P2')]
    @game = Game.new(@players) 
  end
  describe "#new" do
    it "should take a list of players and return a Game object" do
      @game.should be_an_instance_of Game
    end
  end
end
