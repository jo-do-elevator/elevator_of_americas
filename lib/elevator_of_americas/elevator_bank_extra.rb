include ElevatorOfAmericas::Elevators
module ElevatorOfAmericas
  class ElevatorBankExtra < ElevatorBank
    attr_reader :elevators, :dispatches

    def initialize(amount_of_elevators=3)
      @elevators = 1.upto(amount_of_elevators).map{|e|
        ElevatorOfAmericas::ElevatorExtra.new(
          self.random_initial_current_floor
        )
      }
      @dispatches = ElevatorOfAmericas::Dispatches.new
      # Coordinate access to shared data from multiple concurrent threads (dispatches).
      @mutex = Mutex.new
    end

    # Send elevators to floors that are dispatched from often
    def optimize_idle_time
      unless @dispatches.most_frequent.nil?
        self.idle.each{|e|
          e.move_to(self.dispatches.most_frequent.to_i, :up)
        }
      end
    end

    # Multithreaded dispatching
    def dispatch_to(target_floor, direction)
      elevator = self.available(target_floor, direction)
      Thread.new do
        @mutex.synchronize {
          # Slow file access will demonstrate elevator travel time.
          self.optimize_idle_time
          @dispatches.write_dispatch(target_floor)

          elevator.move_to(target_floor, direction)
        }
      end
      elevator
    end
  end
end
