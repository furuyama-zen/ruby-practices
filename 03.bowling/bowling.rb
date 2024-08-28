#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each_with_index do |s, i|
  if s == 'X' && i <= 15
    shots << 10
    shots << 0
  elsif s == 'X'
    shots << 10
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a
p frames
strike = 10
point = 0
frames.each_with_index do |frame, i|
  if i <= 8 && frame[0] == strike
    if frames[i + 1][0] == strike && frames[i + 2][0] == strike
      point += 30
    elsif frames[i + 1][0] == strike && frames[i + 1][1].zero?
      point += 20 + frames[i + 2][0]
    else
      point += 10 + frames[i + 1][0] + frames[i + 1][1]
    end
  elsif i <= 8 && frame.sum == 10
    point += 10 + frames[i + 1][0]
  else
    point += frame.sum
  end
end

p point
