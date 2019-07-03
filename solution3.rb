load './location.rb'

module WithPosition

  def position=(position)
    @position = position
  end

  def position
    @position
  end

  def prev=(prev)
    @prev = prev
  end

  def prev
    @prev
  end

  def time
    x_1, y_1 = @position
    x_2, y_2 = @prev ? @prev.position : [0, 0]
    @time + Math.sqrt(((x_2 - x_1) ** 2) + ((y_2 - y_1) ** 2)).round
  end

end

Location.prepend(WithPosition)

# Assume all location must be gotten position displayed by two dimension
# Assume the distance should be 1: 1 proportional to time.
# Assume decimal points must be rounded.
# Input must be like Osaka Universial Studio(name), 3(time), 50(satisfaction), 0(position for x), 2(position for y)

line = gets
n, m = line.strip.split(', ').map(&:to_i)
p "n must be greater than 1 and then m must be greater then 0" and exit if n < 1 || m < 0

locations = []
location_count = n
while location_count > 0 do
  line = gets
  name, time, satisfaction, position_x, position_y = line.strip.split(', ')
  location = Location.new(name, time, satisfaction)
  location.position = [position_x.to_i, position_y.to_i]
  locations << location
  location_count -= 1
end

memo = []
location = nil
location_size = locations.size
available_time = m

0.upto(location_size) do |i|
  memo[i] = []
  0.upto(available_time) do |t|
    # initialize values
    memo[i][t] = 0 and next if i == 0 || t == 0
    
    # cannot choose current location
    prev_memo = memo[i - 1][t]
    memo[i][t] = prev_memo and next if location.time > t
    
    # calculate maximum value
    next_memo = memo[i - 1][t - location.time] + location.satisfaction
    memo[i][t] = prev_memo and next if prev_memo > next_memo

    # if value is changed means it can move to next location. if then, save previous location
    location.prev = locations[i - 1] if location 
    memo[i][t] = next_memo
  end

  location = locations[i]
end

maximum_satisfaction = memo[location_size][available_time]

p "maximum satisfaction is #{maximum_satisfaction}"
exit