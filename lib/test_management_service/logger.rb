# frozen_string_literal: true

require 'logger'
require 'singleton'

# Logger classes
module TestManagementService
  # A logger, with level configured according to the environment
  class Logger < Logger

    include Singleton
    def initialize
      if ENV['VERBOSE'] || ENV['DEBUG']
        super(STDOUT, level: Logger::DEBUG)
      else
        super(STDOUT, level: Logger::INFO)
      end
      self.datetime_format = '%Y-%m-%d %H:%M:%S'
    end
  end

  $logger = TestManagementService::Logger.instance
end
