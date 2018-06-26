# class Prospector
# represents an individual prospector
class Prospector
  ##########
  # @map
  # the map our prospector is on
  ##########
  # @curr_city
  # the city our prospector is currently in
  ##########
  # @p_name
  # our prospector's name (usually just a number)
  ##########
  # @day
  # the current day of our prospector's adventure
  ##########
  # @gold
  # the amount of gold our prospector is holding
  ##########
  # @silver
  # the amount of silver our prospector is holding
  ##########
  # @num_locations
  # static class instance variable
  # the number of locations we will visit on our adventure
  ##########
  # @gold_price
  # static class instance variable
  # the going exchange rate for gold
  ##########
  # @silver_price
  # static class instance variable
  # the going exchange rate for silver
  def initialize(map, p_name)
    @map = map
    @curr_city = map.start
    @p_name = p_name

    @day = 0
    @gold = 0
    @silver = 0

    @num_locations = 5
    @gold_price = 20.67
    @silver_price = 1.31
  end

  # our prospector has their adventure!
  # visits num_location locations, collecting gold at each one
  def run
    display_start
    (1..(@num_locations - 1)).each do |loc_count|
      run_day loc_count
      last_city = @curr_city
      @curr_city = @curr_city.rand_neighbor
      display_next_city last_city, @curr_city
    end
    run_day @num_locations
    display_result
  end

  # displays our starting message
  def display_start
    puts "Prospector #{@p_name} starting in #{@curr_city.city_name}."
  end

  # displays our transition info for moving between cities
  def display_next_city(curr_city, next_city)
    print "Heading from #{curr_city.city_name} to #{next_city.city_name}, "
    print "holding #{self.class.pluralize @gold, 'gold'} and "
    puts "#{self.class.pluralize @silver, 'silver'}."
  end

  # displays the result of our run
  def display_result
    print "After #{@day} days, Prospector ##{@p_name} returned "
    puts "to San Fransisco with:\n\t#{self.class.pluralize @gold, 'gold'}."
    puts "\t#{self.class.pluralize @silver, 'silver'}."
    puts format("\tHeading home with $%.2f.\n\n", total_earnings)
  end

  # runs an individual day
  # collects gold and silver
  # calls itself recursively to stay in the same location
  def run_day(loc_count)
    @day += 1
    d_silver = @curr_city.rand_silver
    d_gold = @curr_city.rand_gold
    @silver += d_silver
    @gold += d_gold

    puts "\t#{self.class.day_summary d_silver, d_gold, @curr_city.city_name}"
    return unless self.class.stay_in_city?(loc_count, d_silver, d_gold)
    run_day loc_count
  end

  # calculates our total earnings
  def total_earnings
    @gold_price * @gold + @silver_price * @silver
  end

  # tests whether or not we should stay in the same city
  def self.stay_in_city?(loc_count, daily_silver, daily_gold)
    return true if loc_count < 4 && (daily_silver > 0 || daily_gold > 0)
    loc_count >= 4 && (daily_silver >= 3 || daily_gold >= 2)
  end

  # constructs and displays a summary of our day
  def self.day_summary(silver, gold, city_name)
    "Found #{sg_clauses silver, gold} in #{city_name}."
  end

  # constructs and joins clauses for silver and gold
  def self.sg_clauses(silver, gold)
    clauses = []
    clauses << pluralize(gold, 'gold') if gold > 0
    clauses << pluralize(silver, 'silver') if silver > 0
    return clauses.join(' and ') unless clauses.empty?
    'no precious metals'
  end

  # pluralizes an amount of a material
  def self.pluralize(amt, material)
    "#{amt} ounce#{amt == 1 ? '' : 's'} of #{material}"
  end
end
