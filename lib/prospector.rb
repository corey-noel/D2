class Prospector

  def initialize map
    @map = map
  end

  def run
    curr_city = @map.start
    puts "Our adventure begins in #{curr_city.city_name}..."
    puts "=" * 10
  end

  def visit_city city
    silver = cityget_silver
    gold = city.get_gold
  end

end
