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

  point += frames[i + 1][0]
  next if frame[0] != STRIKE

  point += if frames[i + 1][0] == STRIKE && frames[i + 2][0] == STRIKE
             10
           elsif frames[i + 1][0] == STRIKE && frames[i + 1][1].zero?
             frames[i + 2][0]
           else
             frames[i + 1][1]
           end

  next if frame[0] == STRIKE

  point += frames[i + 1][0]
end

p point
