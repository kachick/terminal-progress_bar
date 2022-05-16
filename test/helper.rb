# coding: us-ascii
# frozen_string_literal: true

require 'stringio'
require 'warning'

require 'declare/autorun'

require 'irb'
require 'power_assert/colorize'
require 'irb/power_assert'

Warning[:deprecated] = true
Warning[:experimental] = true

Warning.process do |_warning|
  :raise
end

require_relative '../lib/terminal/progress_bar'
