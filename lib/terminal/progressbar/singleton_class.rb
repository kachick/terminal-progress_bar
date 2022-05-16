# coding: us-ascii
# frozen_string_literal: true

module Terminal
  class ProgressBar
    class << self
      # @group Useful wrapper for constructors

      # @param [Hash] options
      # @yield [instance]
      # @yieldparam [ProgressBar] instance
      # @yieldreturn [void]
      # @return [void]
      def run(options={})
        instance = new(options)
        instance.flush
        yield instance
      ensure
        instance.finish!
        nil
      end

      # @param [Float] interval_sec
      # @param [Hash] options
      # @yield [instance]
      # @yieldparam [ProgressBar] instance
      # @yieldreturn [void]
      # @return [void]
      def auto(interval_sec, options={})
        interval_sec = Float(interval_sec)
        printing_thread = nil

        run(options) do |instance|
          printing_thread = Thread.new do
            loop do
              if instance.finished?
                break
              else
                instance.flush
                sleep(interval_sec)
              end
            end
          end

          yield instance
        end
      ensure
        printing_thread.join if printing_thread
        nil
      end

      # @endgroup
    end
  end
end
