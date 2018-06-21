require_relative 'city.rb'
require 'json'

# class Map
# used to represent our map of the world
class Map
  attr_reader :start

  def initialize
    @cities = []
    @start = nil
  end

  def load_map(file)
    json_obj = JSON.parse(file)
    json_obj['cities'].each { |city| load_city city }
    json_obj['cities'].each { |city| connect_city city }
  end

  def load_city(city)
    city_obj = City.new(city['name'], city['max_silver'], city['max_gold'])
    add_city city_obj
    @start = city_obj if city['is_start']
  end

  def connect_city(city)
    city_obj = get_city(city['name'])
    city['connections'].each { |conn| city_obj.connect get_city(conn) }
  end

  def cities
    @cities.map { |c| c }
  end

  def add_city(city)
    @cities << city
  end

  def get_city(city_name)
    @cities.each do |c|
      return c if c.city_name == city_name
    end
  end
end
