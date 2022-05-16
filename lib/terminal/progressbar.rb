# coding: us-ascii
# frozen_string_literal: true

# Copyright (c) 2012 Kenichi Kamiya

require 'io/console'
require 'optionalargument'
require_relative 'progressbar/version'
require_relative 'progressbar/singleton_class'

module Terminal
  class ProgressBar
    CR = "\r"
    EOL = "\n"
    STOP = '|'
    SPACE = ' '
    DECORATION_LENGTH = "100% #{STOP}#{STOP}".length

    class Error < StandardError; end
    class InvalidPointingError < Error; end

    attr_reader :max_count, :max_width, :pointer, :output
    alias_method :current_count, :pointer

    # @return [Class]
    OptArg = OptionalArgument.define {
      opt(:body_char, must: true,
                      condition: ->v { v.length == 1 },
                      adjuster: ->v { v.to_str.dup.freeze },
                      aliases: [:mark])
      opt(:max_count, default: 100,
                      condition: AND(Integer, ->v { v >= 1 }),
                      adjuster: ->v { v.to_int })
      opt(:max_width, default: $stderr.winsize.last,
                      condition: AND(Integer, ->v { v >= 1 }),
                      adjuster: ->v { v.to_int })
      opt(:output,    default: $stderr,
                      condition: AND(CAN(:print), CAN(:flush)))
    }

    # @param [Hash] options
    # @option options [String, #to_str] :body_char (also :mark)
    # @option options [Integer, #to_int] :max_count
    # @option options [Integer, #to_int] :max_width
    # @option options [IO, StringIO, #print, #flush] :output
    def initialize(**options)
      opts = OptArg.parse(options)

      @body_char = opts.body_char
      @max_count = opts.max_count
      @max_width = opts.max_width
      @output = opts.output
      @pointer = 0
    end

    # @return [String]
    def body_char
      @body_char.dup
    end

    # @return [Integer]
    def max_bar_width
      max_width - DECORATION_LENGTH
    end

    # @return [Integer]
    def current_bar_width
      percentage == 0 ? 0 : (max_bar_width * rational).to_int
    end

    # @return [Fixnum] 1..100
    def percentage
      ((rational * (100 / @max_count)) * 100).to_int
    end

    # @return [String]
    def bar
      "#{@body_char * current_bar_width}#{bar_padding}"
    end

    # @return [String]
    def line
      "#{percentage.to_s.rjust(3)}% #{STOP}#{bar}#{STOP}"
    end

    # @return [void]
    def flush
      @output.print(line)
      @output.print(finished? ? EOL : CR)
      @output.flush
    end

    # @param [Integer, #to_int] point
    def pointable?(point)
      int = point.to_int
      (int >= 0) && (int <= @max_count)
    end

    def finished?
      @pointer == @max_count
    end

    alias_method :end?, :finished?

    # @group Change Pointer

    # @param [Integer, #to_int] point
    # @return [point]
    def pointer=(point)
      int = point.to_int
      raise InvalidPointingError unless pointable?(int)

      @pointer = int
    end

    # @param [Integer, #to_int] step
    # @return [step]
    def increment(step=1)
      new_pointer = @pointer + step.to_int
      raise InvalidPointingError unless pointable?(new_pointer
                                                  )

      @pointer = new_pointer
      step
    end

    # @param [Integer, #to_int] step
    # @return [step]
    def decrement(step=1)
      increment(-step)
      step
    end

    # @return [void]
    def rewind
      @pointer = 0
      nil
    end

    # @return [void]
    def fast_forward
      @pointer = @max_count
      nil
    end

    alias_method :finish, :fast_forward

    [:increment, :decrement, :rewind, :fast_forward, :finish].each do |changer|
      define_method :"#{changer}!" do |*args, &block|
        __send__ changer, *args, &block
        flush
      end
    end

    # @endgroup

    private

    # @return [String]
    def bar_padding
      SPACE * (max_bar_width - current_bar_width)
    end

    # @return [Rational] pointer / max_count
    def rational
      Rational(@pointer, @max_count)
    end
  end
end
