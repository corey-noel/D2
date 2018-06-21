# class Prospector
# represents an individual prospector
class Prospector
  @@num_locations = 5
  @@gold_price = 20.67
  @@silver_price = 1.31

  def initialize(map, p_name)
    @map = map
    @p_name = p_name
    @day = 0
    @gold = 0
    @silver = 0
  end

  def run
    @day = 0
    curr_city = @map.start
    puts "Prospector ##{@p_name} starting in #{curr_city.city_name}."

    (1..@@num_locations).each do |loc_count|
      visit_city curr_city, loc_count
      curr_city = next_city curr_city
    end
    visit_city curr_city, @@num_locations
    display_result
  end

  def next_city(curr_city)
    next_city = curr_city.rand_neighbor
    print "Heading from #{curr_city.city_name} to #{next_city.city_name},"
    print "holding #{pluralize @gold, 'gold'} and "
    puts "#{pluralize @silver, 'silver'}."
    next_city
  end

  def display_result
    money = @@gold_price * @gold + @@silver_price * @silver

    print "After #{@day} days, Prospector ##{@p_name} returned "
    puts 'to San Fransisco with:'
    puts "\t#{pluralize @gold, 'gold'}."
    puts "\t#{pluralize @silver, 'silver'}."
    puts format("\tHeading home with $%.2f", money)
  end

  def visit_city(city, loc_count)
    @day += 1
    daily_silver = city.rand_silver
    daily_gold = city.rand_gold
    @silver += daily_silver
    @gold += daily_gold

    puts "\t#{find_sentence daily_silver, daily_gold, city.city_name}"

    return unless stay_in_city?(loc_count, daily_gold, daily_gold)

    visit_city city, loc_count
  end
end

def stay_in_city?(loc_count, daily_silver, daily_gold)
  return true if loc_count < 4 && (daily_silver > 0 || daily_gold > 0)
  loc_count >= 4 && (daily_silver >= 3 || daily_gold >= 2)
end

def find_sentence(silver, gold, city_name)
  "Found #{sg_clauses silver, gold} in #{city_name}."
end

def sg_clauses(silver, gold)
  if silver > 0 && gold > 0
    gold_clause = pluralize gold, 'gold'
    silver_clause = pluralize silver, 'silver'
    return "#{gold_clause} and #{silver_clause}"
  end
  return pluralize silver, 'silver' if silver > 0
  return pluralize gold, 'gold' if gold > 0
  'no precious metals'
end

def pluralize(amt, material)
  "#{amt} ounce#{amt == 1 ? '' : 's'} of #{material}"
end
