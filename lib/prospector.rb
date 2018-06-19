class Prospector
  @@gold_price = 20.67
  @@silver_price = 1.31
  @@num_locations = 5

  def initialize map, p_name
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

    (1..@@num_locations - 1).each do |loc_count|
      visit_city curr_city, loc_count
      last_city = curr_city
      curr_city = curr_city.get_neighbor
      puts "Heading from #{last_city.city_name} to #{curr_city.city_name}, holding #{pluralize @gold, "gold"} and #{pluralize @silver, "silver"}."
    end
    visit_city curr_city, @@num_locations
    money = @@gold_price * @gold + @@silver_price * @silver

    puts "After #{@day} days, Prospector ##{@p_name} returned to San Fransisco with:"
    puts "\t#{pluralize @gold, "gold"}."
    puts "\t#{pluralize @silver, "silver"}."
    puts "\tHeading home with $%.2f" % money
  end

  def visit_city city, loc_count
    @day += 1
    daily_silver = city.get_silver
    daily_gold = city.get_gold
    @silver += daily_silver
    @gold += daily_gold

    puts "\t#{find_sentence daily_silver, daily_gold, city.city_name}"

    if loc_count < 4
      if daily_silver > 0 or daily_gold > 0
        visit_city city, loc_count
      end
    else
      if daily_silver >= 3 or daily_gold >= 2
        visit_city city, loc_count
      end
    end
  end
end

def find_sentence silver, gold, city_name
  "Found #{sg_clauses silver, gold} in #{city_name}."
end

def sg_clauses silver, gold
  if silver > 0 and gold > 0
    return "#{pluralize gold, "gold"} and #{pluralize silver, "silver"}"
  elsif silver > 0
    return pluralize silver, "silver"
  elsif gold > 0
    return pluralize gold, "gold"
  else
    return "no precious metals"
  end
end

def pluralize amt, material
  "#{amt} ounce#{if amt == 1; ""; else "s"; end} of #{material}"
end
