require 'spec_helper'
require 'pp'

RSpec.describe ElevatorOfAmericas::ElevatorBank do
  describe 'Constants' do
    it "should have a constant for FLOORS" do
      expect(ElevatorOfAmericas::ElevatorBank::FLOORS).to eq(1..25)
    end

    it "should have a constant for FLOOR_LIST" do
      expect(ElevatorOfAmericas::ElevatorBank::FLOOR_LIST).to eq( (1..25).to_a)
    end
  end

  describe '#initialize' do
    let(:bank) { described_class.new() }
    it "should setup a list of 3 elevators as a default" do
      expect(bank.elevators.length).to eq(3)
    end

    it "should setup a list of n elevators when initialized with an integer" do
      elevators = ElevatorOfAmericas::ElevatorBank.new(6).elevators
      expect(elevators.length).to eq(6)
    end

    it 'should choose a random number with a range' do
      expect(bank.dispatch_to(2, :up)).to be_instance_of(ElevatorOfAmericas::Elevator)
    end
  end

  describe '#random_initial_current_floor' do
    let(:bank) { described_class.new() }
    it 'should choose a random number with a range' do
      expect(bank.random_initial_current_floor).to be_between(1, 25).inclusive
    end
  end

  describe '#dispatch_to' do
    it 'should choose a random number with a range' do
      bank = described_class.new()
      expect(bank.dispatch_to(2, :up)).to be_instance_of(ElevatorOfAmericas::Elevator)
    end
    it 'should raise a FloorOutOfRange error' do
      bank = described_class.new()
      expect { bank.dispatch_to(222, :up) }.to raise_error(ElevatorOfAmericas::FloorOutOfRange, 'Floor requested is not available')
    end
  end

end
