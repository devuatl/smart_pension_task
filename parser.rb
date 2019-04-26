#!/usr/bin/env ruby

require './lib/parser.rb'

file_name = ARGV.first

Parser.parse(file_name)