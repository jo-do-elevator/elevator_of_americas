# ElevatorOfAmericas

Welcome! This is a small project to build out an elevator in code. The goals of this project is to write business logic around how an elevator is dispatched.

This project includes 2 classes defined for you. `ElevatorBank` and `Elevator`.

A few requirements:

  * The elevator bank must have at least 3 elevators
  * The elevator bank must have a way to have elevators dispatched to certain floors
  * The elevators must follow rules as to which one is dispatched to which floor.
  * When we instantiate an elevator bank, let's make sure the elevators are on random floors so we have a realistic experience.

Extra Credit:

  * Include semantics about perhaps time and certain floor volume. (IE: If a floor dispatches an elevator more often, should something happen when all elevators are idle?)

# Example of what we're looking to accomplish

```ruby
bank = ElevatorBank.new
bank.dispatch_to(3, :down) # => Figures out which elevator can be dispatched to the elevator and sends it there for a certain direction
bank.elevators => # Returns all elevators and where they are and perhaps state (idle, moving_up, moving_down)
```

# Specs

This also includes `RSpec`, if you're more comfortable with another testing toolkit, please feel free to change it.

What is the return value of dispatch_to to be? How about the chosen elevator in-state

# Homework Completion Notes

## Testing

```shell
bundle exec rspec spec
```

## Exploring Answer

```shell
bundle console
```

```ruby
bank = ElevatorOfAmericas::ElevatorBank.new
bank.elevators.each{|e| puts "#{e.current_floor} #{e.direction}" }
16
12
10
bank.dispatch_to(3, :up)
bank.elevators.each{|e| puts "#{e.current_floor} #{e.direction}" }
16
12
10 down
```

## Exploring Extra

Extra credit feature: Store busy dispatch floors, then send idle elevators to the most frequently dispatched-from floor. Persist dispatches to a file and allow for concurrent elevator movement via multithreading.

If ElevatorBankExtra is used, dispatch_to will return immediately but send the elevator on a timed journey to the target floor. This means that multiple, concurrent dispatches can be handled.

```
git checkout extra
```

```ruby
bank = ElevatorOfAmericas::ElevatorBankExtra.new
bank.elevators.each{|e| puts "#{e.current_floor} #{e.direction}" }
8
7
17
bank.dispatch_to(3, :up)
```

Wait a moment


```ruby
bank.elevators.each{|e| puts "#{e.current_floor} #{e.direction}" }
8
7 down
17
```

Wait a moment


```ruby
bank.elevators.each{|e| puts "#{e.current_floor} #{e.direction}" }
8
7 down
17
```

Wait a moment


```ruby
bank.elevators.each{|e| puts "#{e.current_floor} #{e.direction}" }
8
3
17
```

##

```ruby
bank.dispatches.most_frequent
"3"
bank.dispatch_to(7, :up)
bank.elevators.each{|e| puts "#{e.current_floor} #{e.direction}" }
7
3
3
```
