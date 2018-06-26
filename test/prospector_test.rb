require "minitest/autorun"
require_relative "../lib/prospector.rb"
require_relative "../lib/map.rb"

class ProspectorTest < MiniTest::Test
  def setup
    @p = Prospector.new(Map.new, "#1")
    def @p.set_silver silver; @silver = silver; end
    def @p.set_gold gold; @gold = gold; end
    def @p.set_curr_city c; @curr_city = c; end
  end

  # UNIT TESTS FOR METHOD run

  # UNIT TETS FOR METHOD display_start

  # UNIT TESTS FOR METHOD display_next_city(curr_city, next_city)

  # UNIT TESTS FOR METHOD display_result
  # no equivalence classes
  def test_display_result
    out = /After 0 days/
    assert_output out do
      @p.display_result
    end
  end

  # UNIT TESTS FOR METHOD run_day(loc_count)
  # Equivalence classes
  # no equivalence classes
  # makes no decisions based on params
  def test_run_day_no_metals
    mock_city = MiniTest::Mock.new("mock city")
    def mock_city.rand_silver; 0; end
    def mock_city.rand_gold; 0; end
    def mock_city.city_name; "asd"; end
    @p.set_curr_city mock_city

    @p.run_day(0)
    assert_equal 1, @p.day
  end

  # UNIT TESTS FOR METHOD total_earnings
  # Equivalence classes:
  # @silver = 0, @gold = 0
  # @silver > 0, @gold = 0
  # @silver = 0, @gold > 0
  # @silver > 0, @gold > 0
  def test_total_earnings_zero
    assert_equal 0, @p.total_earnings
  end

  def test_total_earnings_silver
    @p.set_silver 2
    assert_equal 2.62, @p.total_earnings
  end

  def test_total_earnings_gold
    @p.set_gold 2
    assert_equal 41.34, @p.total_earnings
  end

  def test_total_earnings_both
    @p.set_silver 2
    @p.set_gold 2
    assert_equal 43.96, @p.total_earnings
  end

  # UNIT TESTS FOR METHOD self.stay_in_city?
  # Equivalence classes:
  # EARLY loc_count = MIN ... 3
  #   silver = 0, gold = 0 -> leave
  #   silver > 0, gold = 0 -> stay
  #   silver = 0, gold > 0 -> stay
  #   silver > 0, gold > 0 -> stay
  # LATE loc_count = 4 ... MAX
  #   silver < 3, gold < 2 -> leave
  #   silver >= 3, gold < 2 -> stay
  #   silver < 3, gold >= 2 -> stay
  #   silver >= 3, gold >= 2 -> stay
  # tests early stay rules with
  # zero silver
  # zero gold
  def test_stay_early_neither
    refute Prospector.stay_in_city?(2, 0, 0)
  end

  # tests early stay rules with
  # nonzero silver
  # zero gold
  def test_stay_early_silver
    assert Prospector.stay_in_city?(2, 1, 0)
  end

  # tests early stay rules with
  # zero silver
  # nonzero gold
  def test_stay_early_gold
    assert Prospector.stay_in_city?(2, 0, 1)
  end

  # tests early stay rules with
  # nonzero silver
  # nonzero gold
  def test_stay_early_both
    assert Prospector.stay_in_city?(2, 1, 1)
  end

  # tests late stay rules with
  # 2 silver
  # 1 gold
  def test_stay_late_neither
    refute Prospector.stay_in_city?(4, 2, 1)
  end

  # tests late stay rules with
  # 3 silver
  # 1 gold
  def test_stay_late_silver
    assert Prospector.stay_in_city?(4, 3, 1)
  end

  # tests late stay rules with
  # 2 silver
  # 2 gold
  def test_stay_late_gold
    assert Prospector.stay_in_city?(4, 2, 2)
  end

  # tests late stay rules with
  # 3 silver
  # 2 gold
  def test_stay_late_both
    assert Prospector.stay_in_city?(4, 3, 2)
  end

  # UNIT TESTS FOR METHOD self.day_summary
  # no equivalence classes
  # makes no decisions
  # passes equivalence classes onto other methods
  def test_day_summary
    assert_equal "Found 2 ounces of gold in Pittsburgh.", Prospector.day_summary(0, 2, "Pittsburgh")
  end

  # UNIT TESTS FOR METHOD self.sg_clauses
  # Equivalence classes:
  # silver = 0, gold = 0 -> 'no precious metals'
  # silver = 0, gold > 0 -> 'amt ounces of gold'
  # silver > 0, gold = 0 -> 'amt ounces of silver'
  # silver > 0, gold > 0 ->
  # 'amt ounces of gold and amt ounces of silver'
  # tests sg_clauses when both gold and silver are 0
  def test_sg_clauses_both_zero
    assert_equal 'no precious metals', Prospector.sg_clauses(0, 0)
  end

  # tests sg_clauses when only gold is nonzero
  def test_sg_clauses_just_gold
    assert_equal '2 ounces of gold', Prospector.sg_clauses(0, 2)
  end

  # tests sg_clauses when only silver is nonzero
  def test_sg_clauses_just_silver
    assert_equal '2 ounces of silver', Prospector.sg_clauses(2, 0)
  end

  # tests sg_clauses when both gold and silver are nonzero
  def test_sg_clauses_both_nonzero
    assert_equal '2 ounces of gold and 3 ounces of silver', Prospector.sg_clauses(3, 2)
  end

  # UNIT TESTS FOR METHOD self.pluralize
  # Equivalence classes:
  # amt = -MAX ... 0 -> "ounces"
  # amt = 1 -> "ounce"
  # amt = 2 ... MAX -> "ounces"
  # tests pluralize with a negative amount value
  def test_negative_pluralize
    expected = "-10 ounces of goop"
    assert_equal expected, Prospector.pluralize(-10, "goop")
  end

  # tests pluralize with a zero amount value
  def test_zero_pluralize
    expected = "0 ounces of goop"
    assert_equal expected, Prospector.pluralize(0, "goop")
  end

  # EDGE CASE
  # tests pluralize with a single amount value
  def test_single_pluralize
    expected = "1 ounce of goop"
    assert_equal expected, Prospector.pluralize(1, "goop")
  end

  # tests pluralize with a large amount value
  def test_many_pluralize
    expected = "10 ounces of goop"
    assert_equal expected, Prospector.pluralize(10, "goop")
  end
end
