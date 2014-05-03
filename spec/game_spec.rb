require 'spec_helper'

describe Game do
  before :each do
    @players = [Player.new('P1'), Player.new('P2')]
    @game = Game.new(@players) 
  end
  describe "#new" do
    it "should take an array of players and return a Game object" do
      @game.should be_an_instance_of Game
    end
    it "should initialize a new channel" do
      @game.should respond_to(:channel)
    end
    it "should respond to players" do
      @game.should respond_to(:players)
    end
    it "should respond to last round" do
      @game.should respond_to(:last_round)
    end
    it "should respond to won" do
      @game.should respond_to(:won?)
    end
    it "should not respond to round" do
      @game.should_not respond_to(:round)
    end
    it 'should not respond tp count' do
      @game.should_not respond_to(:count)
    end
  end
  describe '#next_player' do
    it 'should return an object of type player' do
      @game.next_player.should be_an_instance_of Player
    end
    it 'should return the next player in the game' do
      player2 = @game.next_player
      player1 = @game.next_player
      @game.next_player.should eql player2
      @game.next_player.should eql player1
    end
    it 'reset player attributes' do
      player = @game.next_player
      player.remaining_dice.should eql 6
      player.scoring_dice.should eql 0
      player.round_points.should eql 0
      player.roll_points.should eql 0
      player.first_roll.should eql true
    end
  end
  describe "#won?" do
    context "is not the last round" do
      it "should return false" do
        @game.won?.should eql nil
      end
    end
    context "is the last round but not all remaining players have thrown" do
      it "should return false" do
        @game.last_round = true
        @game.won?.should eql false 
      end
    end
    context "is the last round and all remaining players have thrown" do
      it "should return true" do
        @game.last_round = true
        @game.won?.should eql false
        @game.won?.should eql true  
      end
    end
  end
end
