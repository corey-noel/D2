require_relative "map.rb"
require "minitest/autorun"

class MapTest < MiniTest::Test

  def test_default_map_length
    mp = Map.new
    mp.load_default_map
    assert_equal 7, mp.cities.length
  end

  # MOCK
  def test_add_city
    mp = Map.new
    c = MiniTest::Mock.new("city 1")
    def c.city_name; @delegator; end
    mp.add_city c
    assert_equal 1, mp.cities.length
  end

  # STUBBING
  def test_get_city_single
    mp = Map.new
    c = MiniTest::Mock.new("city 1")
    def c.city_name; @delegator; end
    mp.add_city c
    assert_equal c, mp.get_city("city 1")
  end

  # STUBBING
  def test_get_city_many
      mp = Map.new
      c = MiniTest::Mock.new("target city")
      def c.city_name; @delegator; end
      mp.add_city c

      (1..30).each do |i|
        city = MiniTest::Mock.new("city #{i}")
        def city.city_name; @delegator; end
        mp.add_city city
      end

      assert_equal c, mp.get_city("target city")
  end


  def test_get_city_empty
    mp = Map.new
    assert_nil mp.get_city("test")
  end

  def test_get_city_no_exist
    mp = Map.new
    (1..30).each do |i|
      city = MiniTest::Mock.new("city #{i}")
      def city.city_name; @delegator; end
      mp.add_city city
    end
    assert_nil mp.get_city("test city")
  end
end
