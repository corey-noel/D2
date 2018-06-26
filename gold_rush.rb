require_relative 'lib/map.rb'
require_relative 'lib/prospector.rb'
require 'json'
begin
  raise ArgumentError, 'Incorrect number of arguments' unless ARGV.length == 2
  srand(Integer(ARGV[0]))
  count = Integer ARGV[1]
  raise ArgumentError, 'Num prospectors must be positive' unless count >= 1
rescue StandardError => e
  puts "#{e.class}: #{e.message}"
  puts 'Usage: ruby gold_rush.rb [seed] [num prospectors]'
  exit 1
end
map = Map.load_map(JSON.parse(File.read('default_map.json')))
(1..count).each { |i| Prospector.new(map, "##{i}").run }
