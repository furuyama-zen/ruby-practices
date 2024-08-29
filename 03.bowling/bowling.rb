#!/usr/bin/env ruby
# frozen_string_literal: true

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

FRAMES = shots.each_slice(2).to_a

STRIKE = 10
point = 0
FRAMES.each_with_index do |frame, i|
  point += frame.sum
  next if frame.sum != 10 || i >= 9

  if frame[0] == STRIKE && FRAMES[i + 1][0] == STRIKE && FRAMES[i + 2][0] == STRIKE
    point += 20
  elsif frame[0] == STRIKE && FRAMES[i + 1][0] == STRIKE && FRAMES[i + 1][1].zero?
    point += 10 + FRAMES[i + 2][0]
  elsif frame[0] == STRIKE
    point += FRAMES[i + 1][0] + FRAMES[i + 1][1]
  elsif frame.sum == 10
    point += FRAMES[i + 1][0]
  end
end

p point
