module ElevatorOfAmericas
  module Elevators
    # Find nearest available elevator to the floor where the dispatch came from.
    def available(target_floor, direction)
      self.proper_direction_or_idle(direction).min_by {|e| (e.current_floor - target_floor).abs }
    end

    # Collect all idle elevators.
    def idle
      self.elevators.reject{|e| !e.idle }
    end

    # Collect all elevators going same direction.
    def proper_direction(direction)
      proper_direction_elevators = self.elevators.reject{|e| e.direction != direction }
    end

    def proper_direction_or_idle(direction)
      (self.idle + self.proper_direction(direction)).flatten.uniq
    end
  end
end
