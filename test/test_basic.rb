# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

MARK = '*'.freeze
OUTPUT = StringIO.new

Declare.describe do
  The Terminal::ProgressBar.new(mark: MARK, output: OUTPUT, max_width: 80) do |bar|
    IS_A Terminal::ProgressBar
    NG bar.finished?

    publics = %w[
      max_count max_width pointer output current_count
      body_char max_bar_width current_bar_width
      percentage bar line flush pointable? finished? end? pointer=
      increment decrement rewind fast_forward finish
      increment! decrement! rewind! fast_forward! finish!
    ]
    publics.each do |pub|
      CAN pub
    end

    The bar.body_char do
      IS MARK
      NG EQUAL?(MARK)
    end

    The bar.output do
      EQUAL OUTPUT
    end

    bar.output.rewind

    The bar.output.read do
      is ''
    end

    bar.increment 10
    bar.output.rewind

    The bar.output.read do
      is ''
    end

    bar.flush
    bar.output.rewind

    The bar.output.read do
      is " 10% |*******                                                                  |\r"
    end

    bar.output.rewind
    bar.increment! 80
    bar.output.rewind

    The bar.output.read do
      is " 90% |*****************************************************************        |\r"
    end

    bar.output.rewind
    bar.increment! 9
    bar.output.rewind

    The bar.output.read do
      is " 99% |************************************************************************ |\r"
    end

    bar.output.rewind

    CATCH Terminal::ProgressBar::InvalidPointingError do
      bar.increment! 2
    end

    bar.increment! 1
    bar.output.rewind

    The bar.output.read do
      is "100% |*************************************************************************|\n"
    end
  end
end
