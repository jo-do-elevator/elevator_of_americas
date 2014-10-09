require 'spec_helper'

RSpec.describe ElevatorOfAmericas::Elevators do
  before do
    allow_any_instance_of(ElevatorOfAmericas::ElevatorBank).to receive(:elevators).and_return(
      [
        ElevatorOfAmericas::Elevator.new(1),
        ElevatorOfAmericas::Elevator.new(12),
        ElevatorOfAmericas::Elevator.new(16)
      ]
    )
  end
  let(:bank) { ElevatorOfAmericas::ElevatorBank.new() }

  describe '#available' do
    it "should return an elevator" do
      bank.dispatch_to(3, :up)
      expect(bank.available(3, :down)).to be_instance_of(ElevatorOfAmericas::Elevator)
    end
    it "should be the closest elevator" do
      available_elevator = bank.dispatch_to(3, :up)
      other_elevator_deltas = bank.elevators.reject{|e| !e.idle }.map{|e| (3 - e.current_floor).abs }
      other_elevator_deltas.each do |delta|
        expect(delta).to be >= (3 - available_elevator.current_floor).abs
      end
    end
  end

  describe '#idle' do
    it "should filter elevators to only idle ones" do
      bank = ElevatorOfAmericas::ElevatorBank.new
      bank.dispatch_to(3, :up)
      elevators = bank.idle
      expect(elevators.find { |e| e.idle == true }).to_not be_nil
    end
  end

  describe '#proper_direction' do
    it "should collect all elevators going same direction" do
      bank.dispatch_to(12, :up)
      proper_direction_elevators = bank.proper_direction(:up)
      expect(proper_direction_elevators.find { |e| e.direction == :down }).to be_nil
    end
  end

  describe '#proper_direction_or_idle' do
    it "should filter elevators to the proper direction" do
      bank = ElevatorOfAmericas::ElevatorBank.new
      bank.dispatch_to(3, :up)
      elevators = bank.proper_direction_or_idle(:up)
      expect(elevators.find { |e| e.idle == true }).to_not be_nil
      expect(elevators.find { |e| e.direction == :down }).to be_nil
    end
  end
end
