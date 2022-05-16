# coding: us-ascii
# frozen_string_literal: true

$VERBOSE = true

require_relative '../lib/terminal/progressbar'

Terminal::ProgressBar.auto 0.2, mark: '*' do |bar|
  50.times do
    sleep 0.1
    bar.increment
  end

  sleep 0.1
  bar.pointer = 15

  30.times do
    sleep 0.1
    bar.increment
  end
end
