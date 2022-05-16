# coding: us-ascii
# frozen_string_literal: true

$VERBOSE = true

require_relative '../lib/terminal/progressbar'

Terminal::ProgressBar.run mark: '*' do |bar|
  50.times do
    sleep 0.1
    bar.increment!
  end
  bar.pointer = 15
  bar.flush
  sleep 2

  30.times do
    sleep 0.1
    bar.increment! 2
  end

  30.times do
    sleep 0.1
    bar.decrement! 2
  end

  bar.pointer = 70
  bar.flush
  sleep 2
end
