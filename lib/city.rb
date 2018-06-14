class City
  attr_reader :city_name
  attr_reader :max_silver
  attr_reader :max_gold

  def initialize city_name, max_silver, max_gold
    @city_name = city_name
    @max_silver = max_silver
    @max_gold = max_gold
    @connections = []
  end

  def connected? other
    @connections.include? other
  end

  def connect other
    if connected? other
      return false
    end
    @connections << other
    other.connect(self)
    true
  end

  def disconnect other
    unless connected? other
      return false
    end
    @connections.reject! { |city| city == other }
    other.disconnect(self)
    true
  end

  def connections
    @connections.map{|city| city}
  end

  def dump_connections
    @connections.each { |city| puts city.city_name }
  end

  def get_neighbor
    if @connections.length <= 0
      return nil
    end
    @connections[rand(@connections.length)]
  end

  def get_silver
    rand(@max_silver + 1)
  end

  def get_gold
    rand(@max_gold + 1)
  end
end
