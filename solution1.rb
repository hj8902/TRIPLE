load './location.rb'

# Input must be like Osaka Universial Studio(name), 3(time), 50(satisfaction)

line = gets
n, m = line.strip.split(', ').map(&:to_i)
p "n must be greater than 1 and then m must be greater then 0" and exit if n < 1 || m < 0

locations = []
location_count = n
while location_count > 0 do
  line = gets
  name, time, satisfaction = line.strip.split(', ')
  locations << Location.new(name, time, satisfaction)
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
    memo[i][t] = memo[i - 1][t] and next if location.time > t

    # calculate maximum value
    memo[i][t] = [memo[i - 1][t], memo[i - 1][t - location.time] + location.satisfaction].max
  end

  location = locations[i]
end

maximum_satisfaction = memo[location_size][available_time]

p "maximum satisfaction is #{maximum_satisfaction}"