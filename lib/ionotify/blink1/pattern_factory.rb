module Ionotify
  module Blink1
    class PatternFactory
      def produce(status, brightness = 1)
        case status
          when 'success'
            RGB.new(0, 255, 0)
          when 'failed'
            RGB.new(255, 0, 0)
          when 'pending'
            RGB.new(0, 0, 255)
          when 'unknown'
            White.new
          else
            raise "'#{status}' is not a known status."
         end.tap do |command|
           command.brightness = brightness if command.respond_to?(:brightness)
         end
      end
    end
  end
end
