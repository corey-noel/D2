# class City
# represents a location on our goldrush map
class City
  attr_reader :city_name
  attr_reader :max_silver
  attr_reader :max_gold

  def initialize(city_name, max_silver, max_gold)
    @city_name = city_name
    @max_silver = max_silver
    @max_gold = max_gold
    @connections = []
  end

  def connected?(other)
    @connections.include? other
  end

  def connect(other)
    return false if connected? other
    @connections << other
    other.connect(self)
    true
  end

  def disconnect(other)
    return false unless connected? other
    @connections.reject! { |city| city == other }
    other.disconnect(self)
    true
  end

  def connections
    @connections.map { |city| city }
  end

  def dump_connections
    @connections.each { |city| puts city.city_name }
  end

  def rand_neighbor
    return nil if @connections.length <= 0
    @connections[rand(@connections.length)]
  end

  def rand_silver
    rand(@max_silver + 1)
  end

  def rand_gold
    rand(@max_gold + 1)
  end
end
