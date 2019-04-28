#!/usr/bin/env ruby

require './lib/parser.rb'
require 'optparse'

DEFAULT_AGGREGATION_TYPE = :visits

aggregation_type = DEFAULT_AGGREGATION_TYPE

option_parser = OptionParser.new do |parser|
  parser.banner = 'Usage: parser.rb [options] FILE'

  parser.on('-u', '--unique') do
    aggregation_type = :unique_views
  end

  parser.on('-v', '--visits') do
    aggregation_type = :visits
  end

  parser.on('-h', '--help', 'Show this message') do
    puts parser
    exit
  end
end

option_parser.parse! # this removes parsed options from ARGV

# Show banner when no file given
if ARGV.empty?
  puts option_parser
  exit
end

file_name = ARGV.first

Parser.parse(file_name, aggregation_type: aggregation_type)