require "minitest/autorun"
require_relative "../lib/map.rb"
require 'json'

class MapTest < MiniTest::Test

  def setup
    @mp = Map.new
  end

  # UNIT TESTS FOR METHOD add_city(city)
  # Equivalence classes:
  # city is not yet in hash -> add it
  # city is already in hash -> replace old city
  # MOCK
  # tests adding a city under normal conditions
  def test_add_city
    c = MiniTest::Mock.new("city 1")
    def c.city_name; @delegator; end
    @mp.add_city c
    assert_equal 1, @mp.cities.length
  end

  # tests adding a city when the name is already in the hash
  # STUBBING
  def test_add_city_name_already_used
    c = MiniTest::Mock.new("city 1")
    def c.city_name; @delegator; end
    @mp.add_city c

    c2 = MiniTest::Mock.new("city 1")
    def c2.city_name; @delegator; end
    @mp.add_city c2

    assert_equal c2, @mp.get_city("city 1")
  end

  # tests that the length is unaffected when
  # adding a city whose name is already in the hash
  # STUBBING
  def test_add_city_name_already_used_cities_length
    c = MiniTest::Mock.new("city 1")
    def c.city_name; @delegator; end
    @mp.add_city c

    c2 = MiniTest::Mock.new("city 1")
    def c2.city_name; @delegator; end
    @mp.add_city c2

    assert_equal 1, @mp.cities.length
  end

  # UNIT TESTS FOR METHOD get_city(city_name)
  # Equivalence classes:
  # city_name is in hash -> return it
  # city_name not in hash -> don't return it
  # STUBBING
  # tests get_city when only one value is in the hash
  def test_get_city_single
    c = MiniTest::Mock.new("city 1")
    def c.city_name; @delegator; end
    @mp.add_city c
    assert_equal c, @mp.get_city("city 1")
  end

  # STUBBING
  # test get_city when many values are in the hash
  def test_get_city_many
    c = MiniTest::Mock.new("target city")
    def c.city_name; @delegator; end
    @mp.add_city c

    (1..30).each do |i|
      city = MiniTest::Mock.new("city #{i}")
      def city.city_name; @delegator; end
      @mp.add_city city
    end

    assert_equal c, @mp.get_city("target city")
  end

  # tests get_city when no values are in the hash
  def test_get_city_empty
    assert_nil @mp.get_city("test")
  end

  # STUBBING
  # tests get_city when our value is not present in the hash
  def test_get_city_no_exist
    (1..30).each do |i|
      city = MiniTest::Mock.new("city #{i}")
      def city.city_name; @delegator; end
      @mp.add_city city
    end
    assert_nil @mp.get_city("test city")
  end

  # UNIT TESTS FOR METHOD self.load_map(json_obj)
  # no equivalence classes
  # SUCCESS: json_obj is structures correctly
  # FAILURE: json_obj is structured incorrectly
  def test_load_map
    json_obj = JSON.parse(File.read("default_map.json"))
    json_map = Map.load_map(json_obj)
    assert_equal 7, json_map.cities.length
  end
end
