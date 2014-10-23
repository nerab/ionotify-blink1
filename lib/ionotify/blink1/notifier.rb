module Ionotify
  module Blink1
    class Notifier
      def initialize(blink1)
        @blink1 = blink1
      end

      def status(status)
        case status
          when 'success'
            @blink1.rgb(0, 64, 0)
          when 'failed'
            @blink1.rgb(64, 0, 0)
          when 'pending'
            @blink1.rgb(0, 0, 32)
          else
            raise "'#{status}' is not a known status."
         end
      end
    end
  end
end
