module Ionotify
  module Blink1
    class Command
      def call
        cmd = "blink1-tool --quiet #{@args}"
        STDERR.puts(cmd) if $DEBUG
        %x[#{cmd}].chomp
      end

      protected

      def initialize(args)
        @args = args
      end
    end

    class StaticCommand < Command
      def initialize(*args)
        if args.any?
          super("--#{self.class.name.split('::').last.downcase}=#{args.join(',')}")
        else
          super("--#{self.class.name.split('::').last.downcase}")
        end
      end
    end

    class White < StaticCommand; end
    class Off < StaticCommand; end
    class Red < StaticCommand; end
    class Green < StaticCommand; end
    class Blue < StaticCommand; end
    class Cyan < StaticCommand; end
    class Magenta < StaticCommand; end
    class Yellow < StaticCommand; end
    class RGB < StaticCommand; end
    class HSB < StaticCommand; end

    class Blink < Command
      def initialize(times = 1, r = nil, g = nil, b = nil)
        if r && g && b
          super("--rgb=#{r},#{g},#{b} --blink=#{times}")
        else
          super("--blink=#{times}")
        end
      end
    end

    class Random < StaticCommand
      def initialize(num = 1)
        super
      end
    end

    class Running < StaticCommand; end

    class Glimmer < Command
      def initialize(num = nil, r = nil, g = nil, b = nil)
        rgb = "--rgb=#{r},#{g},#{b}" if r && g && b

        if num
          super("#{rgb} --glimmer=#{num}")
        else
          super("#{rgb} --glimmer")
        end
      end
    end

    class Read < Command
      def initialize
        super('--rgbread')
      end

      def call
        super.split(',').map{|v| v.to_i(16)}.join(',')
      end
    end
  end
end

__END__

Usage:
  blink1-tool <cmd> [options]
where <cmd> is one of:
  --blink <numtimes>          Blink on/off (use --rgb to blink a color)
  --random, --random=<num>    Flash a number of random colors
  --glimmer, --glimmer=<num>  Glimmer a color with --rgb (num times)
  --running, --running=<num>  Do running animation (num times)
  --rgb=<red>,<green>,<blue>  Fade to RGB value
  --hsb=<hue>,<sat>,<bri>     Fade to HSB value
  --rgbread                   Read last RGB color sent (post gamma-correction)
  --on | --white              Turn blink(1) full-on white
  --off                       Turn blink(1) off
  --red                       Turn blink(1) red
  --green                     Turn blink(1) green
  --blue                      Turn blink(1) blue
  --cyan                      Turn blink(1) cyan (green + blue)
  --magenta                   Turn blink(1) magenta (red + blue)
  --yellow                    Turn blink(1) yellow (red + green)
  --setpattline <pos>         Write pattern RGB val at pos (--rgb/hsb to set)
  --getpattline <pos>         Read pattern RGB value at pos
  --savepattern               Save color pattern to flash (mk2)
  --play <1/0,pos>            Start playing color sequence (at pos)
  --play <1/0,start,end,cnt>  Playing color sequence sub-loop (mk2)
  --servertickle <1/0>[,1/0]  Turn on/off servertickle (w/on/off, uses -t msec)
  --running                   Multi-LED effect (uses --led & --rgb)
  --list                      List connected blink(1) devices
 Nerd functions: (not used normally)
  --eeread <addr>             Read an EEPROM byte from blink(1)
  --eewrite <addr>,<val>      Write an EEPROM byte to blink(1)
  --fwversion                 Display blink(1) firmware version
  --version                   Display blink1-tool version info
and [options] are:
  -d dNums --id all|deviceIds Use these blink(1) ids (from --list)
  -g -nogamma                 Disable autogamma correction
  -m ms,   --millis=millis    Set millisecs for color fading (default 300)
  -q, --quiet                 Mutes all stdout output (supercedes --verbose)
  -t ms,   --delay=millis     Set millisecs between events (default 500)
  -l <led>, --led=<led>       Set which RGB LED in a blink(1) mk2 to use
  -v, --verbose               verbose debugging msgs

Examples
  blink1-tool -m 100 --rgb=255,0,255    # fade to #FF00FF in 0.1 seconds
  blink1-tool -t 2000 --random=100      # every 2 seconds new random color
  blink1-tool --rgb=0xff,0,00 --blink 3 # blink red 3 times
