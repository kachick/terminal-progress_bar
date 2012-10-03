$VERBOSE = true

require_relative '../lib/terminal/progressbar'

include Terminal

ProgressBar.run '*' do |bar|
  50.times do
    sleep 0.02
    bar.succ!
  end
  bar.pointer = 15
  sleep 2

  30.times do
    bar.succ! 2
  end
end
