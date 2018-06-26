require_relative 'city.rb'

# class Map
# used to represent our map of the world
class Map
  attr_reader :start

  ##########
  # @cities
  # a hash of our cities
  # maps city names to city objects
  ##########
  # @start
  # our starting city
  def initialize
    @cities = {}
    @start = nil
  end

  # static factory method
  # loads a map from a JSON object
  # calls upon a similar method for cities
  def self.load_map(json_obj)
    cities_json = json_obj['cities']
    mp = new
    mp.load_cities cities_json
    mp.connect_cities cities_json
    mp
  end

  # helper method for loading a map from JSON
  # iterates over cities_json and loads each city
  def load_cities(cities_json)
    cities_json.each do |city_json|
      city_obj = City.load_city city_json
      add_city city_obj
      @start = city_obj if city_json['is_start']
    end
  end

  # helper method for loading a map from JSON
  # iterates over city_json JSON objects
  # connects each one to its adjacent cities
  def connect_cities(cities_json)
    cities_json.each do |city_json|
      connect_city city_json
    end
  end

  # helper method for loading a map from JSON
  # connects a city to each of its connected cities based on the JSON
  def connect_city(city_json)
    city_obj = get_city(city_json['name'])
    city_json['connections'].each { |conn| city_obj.connect get_city(conn) }
  end

  # returns a copy of the cities array
  def cities
    @cities.map { |city| city }
  end

  # adds a new city to the map
  def add_city(city)
    @cities[city.city_name] = city
  end

  # gets a city by name using hash lookup
  def get_city(city_name)
    @cities[city_name]
  end
end
