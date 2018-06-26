require 'simplecov'
SimpleCov.start
require "minitest/autorun"
require_relative "../lib/map.rb"

class CityTest < MiniTest::Test
  def setup
    @c1 = City.new("City 1", 5, 10)
    @c2 = City.new("City 2", 15, 20)
    @c3 = City.new("City 3", 0, 1000)
    @c4 = City.new("City 4", 1000, 0)
  end

  # UNIT TESTS FOR METHOD initialize(city_name, max_silver, max_gold)
  # No equivalence classes, as this is a very basic constructor
  # tests that a newly created city has the proper name
  def test_new_city_name
    assert_equal "City 1", @c1.city_name
  end

  # tests that a newly created city has the proper silver
  def test_new_city_silver
    assert_equal 5, @c1.max_silver
  end

  # tests that a newly created city has the proper gold
  def test_new_city_gold
    assert_equal 10, @c1.max_gold
  end

  # UNIT TESTS FOR METHOD connect(other)
  # Equivalence classes:
  # other is an instance of class -> connects cities
  # other is already connected -> no action
  # other is nil -> raises an NPE

  # tests that connecting a city works as intended
  def test_city_self_connect
    @c1.connect @c2
    assert @c1.connected? @c2
  end

  # tests that connecting a city works when
  # the city in question is being passed as an argument
  # (connect is symmetrical)
  def test_city_other_connect
    @c1.connect @c2
    assert @c2.connected? @c1
  end

  # EDGE CASE
  # tests that there is no change
  # when a city is connected a second time
  def test_city_already_connected
    @c1.connect @c2
    @c1.connect @c2
    assert_equal 1, @c1.connections.count
  end

  # tests that connect throw an NPE when passed a nil city
  def test_city_nil
    assert_raises StandardError do
      @c1.connect nil
    end
  end

  # UNIT TESTS FOR METHOD connected?(other)
  # Equivalence classes:
  # the two cities are connected
  # the two cities are not connected

  # tests the return value of connected?
  # when the two cities are connected
  def test_city_is_connected
    @c1.connect @c2
    assert @c1.connected? @c2
  end

  # tests the return value of connected?
  # when the two cities are not connected
  def test_city_not_connected
    refute @c1.connected? @c2
  end

  # UNIT TESTS FOR METHOD connections
  # Equivalence classes:
  # the connections list is empty
  # the connections list is not empty

  # EDGE CASE
  # tests the return value of connections when
  # the array is empty
  def test_city_connections_empty
    assert @c1.connections.empty?
  end

  # test that the length of connections
  # increases as we add cities
  def test_city_connections_length
    @c1.connect @c2
    @c1.connect @c3
    @c1.connect @c4

    assert_equal 3, @c1.connections.length
  end

  # UNIT TESTS FOR THE METHOD disconnect(other)
  # Equivalence classes:
  # other is already connected -> it is disconnected
  # other is not yet connected -> no action
  # other is nil -> no action

  # tests that disconnecting a city works
  def test_city_self_disconnect
    @c1.connect @c2
    @c1.disconnect @c2
    refute @c1.connected? @c2
  end

  # tests that disconnecting a city works when the city
  # in question is passed as an argument
  def test_city_other_disconnect
    @c1.connect @c2
    @c1.disconnect @c2
    refute @c2.connected? @c1
  end

  # tests that disconnecting a nil city
  # throws a NPE
  def test_city_nil_disconnect
    @c1.disconnect nil
    assert_equal 0, @c1.connections.length
  end

  # EDGE CASE
  # tests that nothing changes after trying to
  # disconnect cities that are not yet connected
  def test_disconnect_not_connected
    @c1.connect @c2
    @c1.connect @c3
    @c1.disconnect @c4

    assert_equal 2, @c1.connections.length
  end

  # ensures the length of connections after a disconnect
  def test_city_disconnect_connections_length_0
    @c1.connect @c2
    @c1.disconnect @c2
    assert_equal 0, @c1.connections.length
  end

  # ensures the length of connections after a disconnect
  # when the city is passed as an argument
  def test_city_disconnect_other_connections_length_0
    @c1.connect @c2
    @c1.disconnect @c2
    assert_equal 0, @c2.connections.length
  end

  # UNIT TESTS FOR METHOD rand_neighbor
  # Equivalence cases:
  # no neighbors -> nil
  # 1 neighbor -> that neighbor
  # more than 1 neighbor -> a randomly chosen neighbor

  # EDGE CASE
  # tests the get neighbor function on a city with
  # no neighbors - should return nil
  def test_rand_neighbor_no_connections
    assert_nil @c1.rand_neighbor
  end

  # tests the get neighbor function on a city with
  # a single neighbor
  def test_rand_neighbor_one_connection
    @c1.connect @c2
    assert_equal @c2, @c1.rand_neighbor
  end

  # tests the get neighbor function on a city with
  # many neighbors
  def test_rand_neighbor_many_connections
    neighbor_list = [@c2, @c3, @c4]

    @c1.connect @c2
    @c1.connect @c3
    @c1.connect @c4

    assert_includes neighbor_list, @c1.rand_neighbor
  end

  # UNIT TESTS FOR METHOD rand_silver
  # Equivalence classes:
  # max_silver = 0 -> 0
  # max_silver > 0 -> random number from 0 to max_silver

  # tests that the rand_silver function returns a value
  # between 0 and max_silver
  def test_rand_silver
    c1 = City.new("City 1", 10, 1000)
    res = c1.rand_silver
    assert res >= 0 && res <= 10
  end

  # EDGE CASE
  # tests that the rand_silver function returns 0
  # when max_silver is 0
  def test_rand_silver_zero
    c1 = City.new("City 1", 0, 100)
    assert_equal 0, c1.rand_silver
  end

  # UNIT TESTS FOR METHOD rand_gold
  # Equivalence classes:
  # max_gold = 0 -> 0
  # max_gold > 0 -> random number from 0 to max_gold

  # tests that the rand_gold function returns a value
  # between 0 and max_gold
  def test_rand_gold
    c1 = City.new("City 1", 1000, 10)
    res = c1.rand_gold
    assert res >= 0 && res <= 10
  end

  # EDGE CASE
  # tests that the rand_gold function returns 0
  # when max_gold is 0
  def test_rand_gold_zero
    c1 = City.new("City 1", 100, 0)
    assert_equal 0, c1.rand_gold
  end
end
