require_relative 'lib/map.rb'

begin
  raise ArgumentError.new("Incorrect number of arguments") unless ARGV.length == 2
  srand(Integer(ARGV[0]))
  count = Integer ARGV[1]
  raise ArgumentError.new("Num prospectors must be a positive integer") unless count >= 1
rescue StandardError => e
  puts e.message
  puts "Usage: ruby gold_rush.rb [seed] [num prospectors]"
  exit 1
end

(1..count).each do |i|
  mp = Map.new
  mp.load_default_map
  puts "Prospector ##{i}'s adventure begins in #{mp.start.city_name}..."
  # game
end
