require_relative 'lib/map.rb'

if ARGV.length != 2
 puts "Usage: ruby gold_rush.rb [seed] [num prospectors]"
 exit 1
end

begin
  srand(Integer(ARGV[0]))
  count = Integer ARGV[1]
rescue
  puts "Input values must be integers"
  exit 1
end

(1..ARGV[1].to_i).each do |i|
  mp = Map.new
  mp.load_default_map
  puts "Prospector ##{i}'s adventure begins in #{mp.start.city_name}..."
  # game
end
