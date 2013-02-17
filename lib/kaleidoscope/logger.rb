module Kaleidoscope
  module Logger
    def log message
      logger.info("[kaleidoscope] #{message}") if logging?
    end

    def logger
      @logger ||= options[:logger] || ::Logger.new(STDOUT)
    end

    def logger=(logger)
      @logger = logger
    end

    def logging?
      options[:log]
    end
  end
end