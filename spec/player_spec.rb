require 'spec_helper'

describe Player do
   before(:each) do
     @player = Player.new("Colm")
     @player2 = Player.new("James")
   end
   describe "#new" do
     it "should return a player object" do
       @player.should be_an_instance_of Player
     end
     it "should respond to dice" do
       @player.should respond_to(:dice)
     end
     it "should respond to name" do
       @player.should respond_to(:name)
     end
     it "should respond to total_points" do
       @player.should respond_to(:total_points)
     end
     it "should respond to id" do
       @player.should respond_to(:id) 
     end
     it "should have a unique id" do
       @player.id.should_not eql @player2.id
     end
     describe "#roll" do
       it "should return an array of values" do
         @player.roll.should be_an_instance_of Array
       end
       context "remaining dice equals 3" do
         it "should return an array of 3" do
           @player.remaining_dice = 3
           @player.roll.count.should eql 3
         end
       end
       context "remaining dice equals 6" do
         it "should return an array of 6 dice" do
           @player.remaining_dice = 6
           @player.roll.count.should eql 6
         end
       end
     end
     describe "#bank" do
       it "should return add round points to total points" do
         @player.bank.should eql 0
         @player.total_points.should eql 0

         @player.round_points = 100
         @player.bank
         @player.total_points.should eql 100 

         @player.round_points = 50
         @player.bank
         @player.total_points.should eql 150
       end
       it "should reset round_points to 0" do
         @player.round_points = 100
         @player.bank
         @player.round_points.should eql 0
       end
     end
     describe "#accum_points" do
       it "should add roll points to round points" do
         @player.accum_points.should eql 0
         @player.roll_points = 100
         @player.accum_points
         @player.round_points.should eql 100 
       end
       it "should reset roll points to 0" do
         @player.roll_points = 100
         @player.accum_points
         @player.roll_points.should eql 0
       end
     end
     describe "#remaining_dice" do
       context "scoring dice equals 0" do
         it "should return 6" do
           @player.remaining_dice.should eql 6
         end
       end 
       context "scoring dice equals 3" do
         it "should return 3" do
           @player.scoring_dice = 3
           @player.remaining_dice.should eql 3
         end
       end
       context "scoring dice equals 6" do
         it "should return 6" do
           @player.scoring_dice = 6
           @player.remaining_dice.should eql 6
         end
       end
     end
     describe "#to_json" do
       it "should return a Hash" do
         @player.to_json.should be_an_instance_of Hash
       end
     end
     describe "#score" do
       it "should calculate the score given a number of dice" do
         @player.score([1,1,1,2,3,4]).should eql 1000
         @player.score([2,2,2,5]).should eql 250
         @player.score([3,3,3,5,5,5]).should eql 800
         @player.score([1,1,5,5,5]).should eql 700
         @player.score([2,3,4,4,3]).should eql 0
       end
     end
     describe ".winner" do
       before :each do
         @player.round_points = 100
         @player.bank
         @game = double("game", :players => [@player, @player2])
       end
       it "should return the player with the highest score" do
         Player.winner(@game).should eql @player
       end
     end
   end
end
