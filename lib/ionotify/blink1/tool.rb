module Ionotify
  module Blink1
    class Tool
      def rgb(*rgb)
        %x[blink1-tool --quiet --rgb #{rgb.join(',')}]
      end
    end
  end
end
