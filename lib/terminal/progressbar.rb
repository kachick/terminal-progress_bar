# Copyright (c) 2012 Kenichi Kamiya

module Terminal

  class ProgressBar

    DEFAULT_WIDTH = 80
    CR = "\r".freeze
    EOL = "\n".freeze
    STOP = '|'.freeze
    SPACE = ' '.freeze
    DECORATION_LENGTH ="100% #{STOP}  #{STOP}".length

    class Error < StandardError; end
    class InvalidPointingError < Error; end

    class << self

      # @return [ProgressBar]
      def run(body_char, max_count=100, max_width=DEFAULT_WIDTH, output=$stderr)
        instance = new body_char, max_count=100, max_width=DEFAULT_WIDTH, output=$stdout
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
    def initialize(body_char, max_count=100, max_width=DEFAULT_WIDTH, output=$stderr)
      raise TypeError unless body_char.length == 1

      @body_char = body_char.to_str.dup.freeze
      @max_count = max_count.to_int
      @max_width = max_width.to_int
      @output = output
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
      max_bar_width / (100 / percentage)
    end

    # @return [Rational] pointer / max_count
    def rational
      Rational @pointer, @max_count
    end

    # @return [Fixnum] 1..100
    def percentage
      ((rational * (100 / @max_count)) * 100).to_i
    end

    # @return [String]
    def line
      "#{percentage.to_s.rjust 3}% #{STOP} #{bar} #{STOP}"
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

    # @return [void]
    def succ!(step=1)
      @pointer += step
      raise InvalidPointingError unless @pointer <= @max_count
      flush
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