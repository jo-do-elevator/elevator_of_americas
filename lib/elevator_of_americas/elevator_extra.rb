module ElevatorOfAmericas
  class ElevatorExtra < Elevator
    # Calclulte the deltas between target floor and current floor.
    def floors_to_travel(target_floor)
      (@current_floor - target_floor).abs
    end

    # Set a time for travelling, to have more fun with concurrent dispatches
    def time_per_floor
      1
    end

    def move_to(target_floor, dispatch_direction=nil)
      @idle = false
      @target_floor = target_floor
      unless dispatch_direction.nil?
        @direction = determine_direction(target_floor, dispatch_direction)
      end
      # Doo-de-doo... musac
      sleep( self.time_per_floor * floors_to_travel(target_floor) )
      # Bing
      @idle = true
      @target_floor = nil
      @direction = nil
      @current_floor = target_floor
      self
    end
  end
end
