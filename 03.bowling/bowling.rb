#!/usr/bin/env ruby
# frozen_string_literal: true

STRIKE = 10
score = ARGV[0]
scores = score.split(',')

shots = []
scores.each_with_index do |s, i|
  if s == 'X'
    shots << 10
    shots << 0 if i <= 15
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = 0
frames.each_with_index do |frame, i|
  point += frame.sum
  next if frame.sum != 10 || i >= 9

  if frame[0] == STRIKE
    if frames[i + 1][0] == STRIKE && frames[i + 2][0] == STRIKE
      point += 20
    elsif frames[i + 1][0] == STRIKE && frames[i + 1][1].zero?
      point += 10 + frames[i + 2][0]
    else
      point += frames[i + 1][0] + frames[i + 1][1]
    end
  elsif frame.sum == 10
    point += frames[i + 1][0]
  end
end

p point
