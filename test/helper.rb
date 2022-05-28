# coding: us-ascii
# frozen_string_literal: true

require 'stringio'
require 'warning'

require 'declare/autorun'

puts 'Investigate https://github.com/kachick/terminal-progress_bar/runs/6626299850?check_suite_focus=true'

pp ENV.select { |key, _value| /TERM/i.match?(key) }

module Reline::Terminfo
  def self.curses_dl_files
    case RUBY_PLATFORM
    when /mingw/, /mswin/
      # aren't supported
      []
    when /cygwin/
      %w[cygncursesw-10.dll cygncurses-10.dll]
    when /darwin/
      %w[libncursesw.dylib libcursesw.dylib libncurses.dylib libcurses.dylib]
    else
      %w[libncursesw.so libcursesw.so libncurses.so libcurses.so]
    end
  end
end

require 'irb'
require 'power_assert/colorize'
require 'irb/power_assert'

Warning[:deprecated] = true
Warning[:experimental] = true

Warning.process do |_warning|
  :raise
end

require_relative '../lib/terminal/progress_bar'
