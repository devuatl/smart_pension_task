#!/usr/bin/env ruby

file_name = ARGV.first

paths = File.open(file_name).each_line.to_a.map{|line| line.split(' ').first }
path_views = paths.inject(Hash.new(0)) { |acc, path| acc[path] = acc[path] + 1; acc }
path_views_descending = path_views.sort_by { |_key, value| value }.reverse
path_views_descending.each {|path, views| puts "#{path} #{views}"}