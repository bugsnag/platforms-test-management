# frozen_string_literal: true

require 'mongoid'

require_relative 'log_schema'

module TestManagementService
  module LogRecorder
    class LogRecorder
      def initialize
        host = ENV['MONGODB_HOST']
        database = ENV['MONGODB_DB']
        user = ENV['MONGODB_USER']
        password = ENV['MONGODB_PASS']
        Mongoid.configure do |config|
          config.clients.default = {
            hosts: [host],
            database: database,
            options: {
              user: user,
              password: password,
              auth_source: 'admin'
            }
          }
          config.log_level = :warn
        end
      end

      def insert_log(log)
        document = Log.new(log)
        document.save
      end
    end
  end
end
