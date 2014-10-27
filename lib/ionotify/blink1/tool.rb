module Ionotify
  module Blink1
    class Tool
      def rgb(*rgb)
        %x[blink1-tool --quiet --rgb #{rgb.join(',')}]
      end

      def off
        %x[blink1-tool --quiet --off]
      end
    end
  end
end
