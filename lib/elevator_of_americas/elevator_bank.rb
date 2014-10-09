include ElevatorOfAmericas::Elevators

module ElevatorOfAmericas
  class ElevatorBank
    FLOORS = (1..25)
    FLOOR_LIST = FLOORS.to_a

    attr_reader :elevators

    def initialize(amount_of_elevators=3)
      @elevators = 1.upto(amount_of_elevators).map{|e|
        ElevatorOfAmericas::Elevator.new(
          self.random_initial_current_floor
        )
      }
    end

    def random_initial_current_floor
      rand(FLOORS)
    end

    def dispatch_to(target_floor, direction)
      if (target_floor < FLOOR_LIST.first || target_floor > FLOOR_LIST.last)
        raise FloorOutOfRange, 'Floor requested is not available'
      end
      elevator = self.available(target_floor, direction)
      elevator.move_to(target_floor, direction)
      elevator
    end
  end
end
