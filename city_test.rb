require_relative "city.rb"
require "minitest/autorun"

class CityTest < MiniTest::Test

  # tests that a newly created city has the proper name
  def test_new_city_name
    c = City.new("test name", 10, 20)
    assert_equal "test name", c.city_name
  end

  # tests that a newly created city has the proper silver
  def test_new_city_silver
    c = City.new("test name", 10, 20)
    assert_equal 10, c.max_silver
  end

  # tests that a newly created city has the proper gold
  def test_new_city_gold
    c = City.new("test name", 10, 20)
    assert_equal 20, c.max_gold
  end

  # tests that connecting a city works as intended
  def test_city_self_connect
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c1.connect c2
    assert c1.connected? c2
  end

  # tests that connecting a city works when
  # the city in question is passed as an argument
  # connect is symmetrical
  def test_city_other_connect
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c1.connect c2
    assert c2.connected? c1
  end

  # test that the length of connections
  # increases as we add cities
  def test_city_connections_length
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c3 = City.new("City 3", 15, 15)
    c4 = City.new("City 4", 20, 20)

    c1.connect c2
    c1.connect c3
    c1.connect c4

    assert_equal 3, c1.connections.length
  end

  # tests that disconnecting a city works
  def test_city_self_disconnect
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c1.connect c2
    c1.disconnect c2
    refute c1.connected? c2
  end

  # tests that disconnecting a city works when the city
  # in question is passed as an argument
  def test_city_other_disconnect
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c1.connect c2
    c1.disconnect c2
    refute c2.connected? c1
  end

  # ensures the length of connections after a disconnect
  def test_city_disconnect_connections_length_0
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c1.connect c2
    c1.disconnect c2
    assert_equal 0, c1.connections.length
  end

  # ensures the length of connections after a disconnect
  # when the city is passed as an argument
  def test_city_disconnect_other_connections_length_0
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c1.connect c2
    c1.disconnect c2
    assert_equal 0, c2.connections.length
  end

  # tests the get neighbor function on a city with
  # no neighbors - should return nil
  def test_get_neighbor_no_connections
    c1 = City.new("Test City", 10, 20)
    assert_nil c1.get_neighbor
  end

  # tests the get neighbor function on a city with
  # a single neighbor
  def test_get_neighbor_one_connection
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c1.connect c2
    assert_equal c2, c1.get_neighbor
  end

  # tests the get neighbor function on a city with
  # many neighbors
  def test_get_neighbor_many_connections
    c1 = City.new("City 1", 5, 5)
    c2 = City.new("City 2", 10, 10)
    c3 = City.new("City 3", 15, 15)
    c4 = City.new("City 4", 20, 20)

    neighbor_list = [c2, c3, c4]

    c1.connect c2
    c1.connect c3
    c1.connect c4

    assert_includes neighbor_list, c1.get_neighbor
  end

  # tests that the get_silver function returns a value
  # between 0 and max_silver
  def test_get_silver
    c1 = City.new("City 1", 10, 1000)
    res = c1.get_silver
    assert res >= 0 && res <= 10
  end

  # tests that the get_gold function returns a value
  # between 0 and max_gold
  def test_get_gold
    c1 = City.new("City 1", 1000, 10)
    res = c1.get_gold
    assert res >= 0 && res <= 10
  end

  # tests that the get_silver function returns 0
  # when max_silver is 0
  def test_get_silver_zero
    c1 = City.new("City 1", 0, 100)
    assert_equal 0, c1.get_silver
  end

  # tests that the get_gold function returns 0
  # when max_gold is 0
  def test_get_gold_zero
    c1 = City.new("City 1", 100, 0)
    assert_equal 0, c1.get_gold
  end
end
