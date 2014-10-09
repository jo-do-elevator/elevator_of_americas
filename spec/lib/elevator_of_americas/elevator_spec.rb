require 'spec_helper'

RSpec.describe ElevatorOfAmericas::Elevator do
  let(:elevator) { described_class.new(12) }

  describe '#initialize' do
    it "should set idle to true" do
      expect(elevator.idle).to be true
    end

    it "should set direction to nil" do
      expect(elevator.direction).to be_nil
    end

    it "should set current_floor" do
      expect(elevator.current_floor).to be(12)
    end

    it "should set target_floor to be nil" do
      expect(elevator.target_floor).to be_nil
    end
  end

  describe '#move_to lower floor' do
    before { elevator.move_to(11, :up) }
    it "should set idle to false" do
      expect(elevator.idle).to be false
    end
    it "should set idle to false" do
      expect(elevator.direction).to eq(:down)
    end
    it "should set target_floor" do
      expect(elevator.target_floor).to eq(11)
    end
  end

  describe '#move_to higher floor' do
    before { elevator.move_to(13, :up) }
    it "should set idle to false" do
      expect(elevator.idle).to be false
    end
    it "should set idle to false" do
      expect(elevator.direction).to eq(:up)
    end
    it "should set target_floor" do
      expect(elevator.target_floor).to eq(13)
    end
  end

  describe '#move_to same floor (heading up)' do
    before { elevator.move_to(12, :up) }
    it "should set idle to false" do
      expect(elevator.idle).to be false
    end
    it "should set idle to false" do
      expect(elevator.direction).to be_nil
    end
    it "should set target_floor" do
      expect(elevator.target_floor).to eq(12)
    end
  end

  describe '#move_to same floor (heading down)' do
    before { elevator.move_to(12, :down) }
    it "should set idle to false" do
      expect(elevator.idle).to be false
    end
    it "should set idle to false" do
      expect(elevator.direction).to be_nil
    end
    it "should set target_floor" do
      expect(elevator.target_floor).to eq(12)
    end
  end

  describe '#determine_direction' do
    it "should determine direction as down (dispatched up from below)" do
      expect(elevator.determine_direction(2, :up)).to eq(:down)
    end
    it "should determine direction as up (dispatched up from above)" do
      expect(elevator.determine_direction(24, :up)).to eq(:up)
    end
    it "should determine direction as down (dispatched down from below)" do
      expect(elevator.determine_direction(2, :down)).to eq(:down)
    end
    it "should determine direction as up (dispatched up from above)" do
      expect(elevator.determine_direction(24, :up)).to eq(:up)
    end
    it "should determine direction as nil (dispatched up from same)" do
      expect(elevator.determine_direction(12, :up)).to be_nil
    end
    it "should determine direction as nil (dispatched up from same)" do
      expect(elevator.determine_direction(12, :up)).to be_nil
    end
  end
end
