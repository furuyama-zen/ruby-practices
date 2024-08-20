#!/usr/bin/env ruby  
require "date"
require "optparse"

opt = OptionParser.new
option = {}
opt.on("-y") {|year| option[:y] = year}
opt.on("-m") {|month| option[:m] = month}
opt.parse!(ARGV)

default_date = DateTime.now

if option[:y]
  year = ARGV[0].to_i
  month = ARGV[1].to_i
elsif option[:m]
  year = default_date.year
  month = ARGV[0].to_i
else
  year = default_date.year
  month = default_date.month
end

start_date = Date.new(year, month)
end_date = Date.new(year, month, -1)

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

start_date.wday.times do
  print "   "
end

(start_date..end_date).each do |date|
  print date.day.to_s.rjust(2) + " "
  if date.saturday?
    puts
  end
end

puts