# frozen_string_literal: true

require 'mongoid'

require_relative 'report_schema'

module TestManagementService
  module TestReports
    class ReportHandler
      def initialize
        host = ENV['MONGODB_HOST']
        database = ENV['MONGODB_DB']
        user = ENV['MONGODB_USER']
        password = ENV['MONGODB_PASS']
        Mongoid.configure do |config|
          config.clients.default = {
            hosts: [host],
            database: database,
            user: user,
            password: password
          }
          config.log_level = :warn
        end
      end

      def insert_report(report)
        document = Report.new(report)
        document.save
      end
    end
  end
end
