require 'simplecov'
SimpleCov.start do
  add_filter "test/*.rb"
end
require "minitest/autorun"

require_relative "map_test.rb"
require_relative "city_test.rb"
require_relative "prospector_test.rb"

