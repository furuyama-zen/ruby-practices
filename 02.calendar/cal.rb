#!/usr/bin/env ruby  
require "date"
require "optparse"

default_date = Date.today

opt = OptionParser.new
option = {}
opt.on("-y year") {|year| option[:y] = year}
opt.on("-m month") {|month| option[:m] = month}
opt.parse!(ARGV)

year = option[:y] ? option[:y].to_i : default_date.year
month = option[:m] ? option[:m].to_i : default_date.month

start_date = Date.new(year, month)
end_date = Date.new(year, month, -1)

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

print "   " * start_date.wday

(start_date..end_date).each do |date|
  print date.day.to_s.rjust(2)
  print " " if !date.saturday?
  puts if date.saturday?
end

puts
