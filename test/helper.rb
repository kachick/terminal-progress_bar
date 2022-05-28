# coding: us-ascii
# frozen_string_literal: true

require 'stringio'
require 'warning'

require 'declare/autorun'

# Investigate https://github.com/kachick/terminal-progress_bar/runs/6626299850?check_suite_focus=true
pp ENV.select { |key, _value| /TERM/i.match?(key) }

require 'irb'
require 'power_assert/colorize'
require 'irb/power_assert'

Warning[:deprecated] = true
Warning[:experimental] = true

Warning.process do |_warning|
  :raise
end

require_relative '../lib/terminal/progress_bar'
