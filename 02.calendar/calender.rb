#!/usr/bin/env ruby

require "date"
require "optparse"

# 引数を読み込む
opt = OptionParser.new
option = {}
opt.on("-y") {|x| option[:y] = x}
opt.on("-m") {|x| option[:m] = x}
opt.parse!(ARGV)

# 引数チェック
if option[:y] && option[:m]
    year = ARGV[0].to_i
    month = ARGV[1].to_i
    start_date = Date.new(year,month)
    end_date = Date.new(year,month, -1)
elsif option[:m]
    date = DateTime.now
    year = date.year
    month = ARGV[0].to_i
    start_date = Date.new(year,month)
    end_date = Date.new(year,month, -1)
elsif !(option[:y] && option[:m])
    date = DateTime.now
    year = date.year
    month = date.month
    start_date = Date.new(year,month)
    end_date = Date.new(year,month, -1)
end

# 最後の日付を取得する
end_number = end_date.day.to_i

# 日付の表示のずれを調整するために0埋めの配列を作成する。
zero_list = Array.new(start_date.wday) {|i| i = 0}
number_list = [*1..end_number]
merge_list = zero_list + number_list

# 1行目を表示する
puts "      " + month.to_s + "月" + " " + year.to_s

# 日から月を表示する
days = {0 => "日", 1=> "月", 2=> "火", 3=> "水", 4=> "木", 5=> "金", 6=> "土"}
days.each_value do |day|
    if day != "土"
        print day + " "
    else
        puts day
    end
end

# 日付を表示する
count = 1
merge_list.each do |number|
    # 日付の値が0の場合、半角スペースを出力する
    if number == 0
        print "   "
    elsif count % 7 != 0 && number.to_s.length < 2
        print  " " + number.to_s + " "
    elsif count % 7 != 0
        print number.to_s + " "
    elsif count % 7 == 0 && number.to_s.length < 2
        puts " " + number.to_s + " "
    elsif count % 7 == 0
        puts number.to_s
    end
    count += 1
end

puts ""
