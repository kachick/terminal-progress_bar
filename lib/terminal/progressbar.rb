# Copyright (c) 2012 Kenichi Kamiya

require 'optionalargument'

module Terminal

  class ProgressBar

    DEFAULT_WIDTH = 80
    CR = "\r".freeze
    EOL = "\n".freeze
    STOP = '|'.freeze
    SPACE = ' '.freeze
    DECORATION_LENGTH ="100% #{STOP}#{STOP}".length

    class Error < StandardError; end
    class InvalidPointingError < Error; end

    OptArgs = OptionalArgument.define {
      opt :max_count, default: 100,
                        condition: AND(Integer, ->v{v >= 1}),
                        adjuster: ->v{v.to_int}
      opt :max_width, default: DEFAULT_WIDTH,
                        condition: AND(Integer, ->v{v >= 1}),
                        adjuster: ->v{v.to_int}
      opt :output, default: $stderr,
                     condition: CAN(:print)
    }

    class << self

      # @return [ProgressBar]
      def run(body_char, options={})
        instance = new body_char, options
        instance.flush
        yield instance
      ensure
        instance.finish
        instance
      end

    end

    attr_reader :max_count, :max_width, :pointer
    alias_method :current_count, :pointer

    # @param [String, #to_str] body_char
    # @param [Integer, #to_int] max_count
    # @param [Integer, #to_int] max_width
    # @param [IO] output
    def initialize(body_char, options={})
      raise TypeError unless body_char.length == 1
      options = OptArgs.parse options

      @body_char = body_char.to_str.dup.freeze
      @max_count = options.max_count
      @max_width = options.max_width
      @output = options.output
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

    # @return [String]
    def bar_padding
      SPACE * (max_bar_width - current_bar_width)
    end

    # @return [Integer]
    def current_bar_width
      percentage == 0 ? 0 : max_bar_width / (100 / percentage)
    end

    # @return [Rational] pointer / max_count
    def rational
      Rational @pointer, @max_count
    end

    # @return [Fixnum] 1..100
    def percentage
      ((rational * (100 / @max_count)) * 100).to_int
    end

    # @return [String]
    def line
      "#{percentage.to_s.rjust 3}% #{STOP}#{bar}#{STOP}"
    end

    # @return [String]
    def bar
      "#{@body_char * current_bar_width}#{bar_padding}"
    end

    # @return [void]
    def flush
      @output.print line
      @output.print(finished? ? EOL : CR)
    end

    # @param [Integer, #to_int] point
    # @return [point]
    def pointer=(point)
      int = point.to_int
      raise InvalidPointingError unless pointable? int
      @pointer = int
      flush
      point
    end

    # @param [Integer, #to_int] point
    def pointable?(point)
      int = point.to_int
      (int >= 0) && (int <= @max_count)
    end

    # @param [Integer, #to_int] step
    # @return [void]
    def increment(step=1)
      step = step.to_int
      @pointer += step
      raise InvalidPointingError unless pointable? @pointer
      flush
    end

    alias_method :succ!, :increment

    # @param [Integer, #to_int] step
    # @return [void]
    def decrement(step=1)
      increment(-step)
    end

    # @return [void]
    def rewind
      @pointer = 0
      flush
    end

    # @return [void]
    def fast_forward
      @pointer = @max_count
      flush
    end

    alias_method :finish, :fast_forward

    def finished?
      @pointer == @max_count
    end

  end

end