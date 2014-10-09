module ElevatorOfAmericas
  class Dispatches
    def path
      File.expand_path('tmp/dispatches.txt')
    end

    def dispatches
      file = File.open(self.path, "r")
      lines = file.read.split(/\n/)
      file.close
      lines
    end

    def write_dispatch(target_floor)
      file = File.open(self.path, 'w')
      file.write(target_floor)
      file.close
    end

    def frequency
      self.dispatches.inject(Hash.new(0)) { |k,v| k[v] += 1; k }
    end

    def most_frequent
      self.dispatches.max_by { |v| self.frequency[v] }
    end
  end
end
