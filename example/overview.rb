$VERBOSE = true

require_relative '../lib/terminal/progressbar'

include Terminal

ProgressBar.run '*' do |bar|
  p bar
  50.times do
    sleep 0.1
    bar.succ!
  end
end
