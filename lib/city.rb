# class City
# represents a location on our goldrush map
class City
  attr_reader :city_name
  attr_reader :max_silver
  attr_reader :max_gold

  ##########
  # @city_name
  # the name of our city
  ##########
  # @max_silver
  # the max silver payout for a day
  ##########
  # @max_gold
  # the max gold payout for a day
  ##########
  # @connections
  # an array of connections
  def initialize(city_name, max_silver, max_gold)
    @city_name = city_name
    @max_silver = max_silver
    @max_gold = max_gold
    @connections = []
  end

  # helper method for loading a map from JSON
  # loads a city from its JSON
  def self.load_city(city_json)
    new city_json['name'], city_json['max_silver'], city_json['max_gold']
  end

  # tests if a city is connected to another city
  def connected?(other)
    @connections.include? other
  end

  # connects two cities to each other
  # (calls the other city's connect method)
  def connect(other)
    return false if connected? other
    @connections << other
    other.connect(self)
    true
  end

  # disconnects two cities from each other
  # (calls the other city's disconnect method)
  def disconnect(other)
    return false unless connected? other
    @connections.reject! { |city| city == other }
    other.disconnect(self)
    true
  end

  # returns a copy of the connections array
  def connections
    @connections.map { |city| city }
  end

  # gets a neighboring at random
  def rand_neighbor
    len = @connections.length
    return nil if @connections.empty?
    @connections[rand(len)]
  end

  # returns a random amount of silver
  # ranges from 0 up to and including the max_silver value
  def rand_silver
    rand(@max_silver + 1)
  end

  # returns a random amount of gold
  # ranges from 0 up to and include the max_gold value
  def rand_gold
    rand(@max_gold + 1)
  end
end
