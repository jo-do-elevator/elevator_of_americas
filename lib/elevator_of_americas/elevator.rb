module ElevatorOfAmericas
  class Elevator
    attr_reader :idle, :direction, :current_floor, :target_floor
    def initialize(current_floor)
      @idle = true
      @direction = nil
      @current_floor = current_floor
      @target_floor = nil
    end

    def move_to(target_floor, dispatch_direction)
      @idle = false
      @direction = determine_direction(target_floor, dispatch_direction)
      @target_floor = target_floor
      self
    end

    def determine_direction(target_floor, dispatch_direction)
      if target_floor > @current_floor
        :up
      elsif target_floor < @current_floor
        :down
      else
        nil
      end
    end
  end
end
