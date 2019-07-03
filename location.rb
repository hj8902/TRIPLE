class Location

  attr_reader :name, :time, :satisfaction

  def initialize(name, time, satisfaction)
    @name = name
    @time = time.to_i
    @satisfaction = satisfaction.to_i
  end

end