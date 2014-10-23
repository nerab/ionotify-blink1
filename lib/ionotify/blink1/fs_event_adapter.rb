def mac?
  RUBY_PLATFORM.downcase.include?('darwin')
end

def linux?
  RUBY_PLATFORM.downcase.include?('linux')
end

require 'rb-inotify' if linux?
require 'rb-fsevent' if mac?
require 'forwardable'

#
# Adapted from
# https://devblog.supportbee.com/2012/07/18/using-platform-dependent-gems-rb-inotify-and-rb-fsevent/
#
class FsEventAdapter
  attr_reader :notifier

  extend Forwardable
  def_delegators :@notifier, :run, :stop


  #
  # Accepts the ablosute_path which the notifier
  # will monitor
  #
  def initialize(watched_files)
    @watched_files = Array(watched_files)
    @notifier = INotify::Notifier.new if linux?
    @notifier = FSEvent.new if mac?
  end

  #
  # Accepts a Proc object containing the code
  # to be executed when a notifier event occurs
  #
  def watch
    raise 'Missing block - what should I do if a file changes?' unless block_given?

    if linux?
      @notifier.watch(@watched_files, :modify) do |file|
        yield file
      end
    elsif mac?
      dirs = @watched_files.map{|f| File.dirname(f)}

      @notifier.watch(dirs, file_events: true) do |files|
        files.each do |file|
          yield file if @watched_files.include?(file)
        end
      end
    end
  end
end
