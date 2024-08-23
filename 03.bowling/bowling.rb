#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a
exclude_last_frame = frames[0..8]
last_frame = []

frames[9..].each do |frame|
  frame.each do |number|
    last_frame.push(number) if number.positive?
  end
end

last_frame[0] = 0 if last_frame[0].nil?
last_frame[1] = 0 if last_frame[1].nil?
last_frame[2] = 0 if last_frame[2].nil?

point = 0
exclude_last_frame.each_with_index do |frame, i|
  if i <= 6 && frame[0] == 10 && exclude_last_frame[i + 1][0] == 10 && exclude_last_frame[i + 2][0] == 10
    point += 30
  elsif i == 7 && frame[0] == 10 && exclude_last_frame[i + 1][0] == 10 && last_frame[0] == 10
    point += 30
  elsif i == 8 && frame[0] == 10 && last_frame[0] == 10 && last_frame[1] == 10
    point += 30
  elsif i <= 6 && frame[0] == 10 && exclude_last_frame[i + 1][0] == 10 && exclude_last_frame[i + 2][0] != 10
    point += 10 + exclude_last_frame[i + 1][0] + exclude_last_frame[i + 2][0]
  elsif i <= 6 && frame[0] == 10
    point += 10 + exclude_last_frame[i + 1][0] + exclude_last_frame[i + 1][1]
  elsif i == 7 && frame[0] == 10
    point += 10 + exclude_last_frame[i + 1][0] + last_frame[0]
  elsif i == 8 && frame[0] == 10
    point += 10 + last_frame[0] + last_frame[1]
  elsif i <= 7 && frame.sum == 10
    point += 10 + exclude_last_frame[i + 1][0]
  elsif i == 8 && frame.sum == 10
    point += 10 + last_frame[0]
  elsif i <= 6 && frame[0] == 10
    point += 10 + exclude_last_frame[i + 1][0] + exclude_last_frame[i + 1][1]
  elsif i == 7 && frame[0] == 10
    point += 10 + exclude_last_frame[i + 1][0] + last_frame[0]
  elsif i == 8 && frame[0] == 10
    point += 10 + last_frame[0] + last_frame[1]
  else
    point += frame.sum
  end
end

p point + last_frame.sum
