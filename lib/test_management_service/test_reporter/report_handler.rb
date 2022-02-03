# frozen_string_literal: true

require 'mongoid'

require_relative 'report_schema'

module TestManagementService
  module TestReports
    class ReportHandler
      def initialize
        host = ENV['MONGODB_HOST']
        database = ENV['MONGODB_DB']
        Mongoid.configure do |config|
          config.clients.default = {
            hosts: [host],
            database: database,
          }
          config.log_level = :warn
        end
      end

      def insert_report(report)
        document = {}
        document['configuration'] = Configuration.new(report['configuration'])
        document['build'] = Build.new(report['build'])
        document['session'] = report['session'].map do |session|
          session['elements'].map! do |element|
            element['steps'].map! { |step| Step.new(step) } unless element['steps'].nil?
            element['before'].map! { |before| Before.new(before) } unless element['before'].nil?
            element['after'].map! { |after| After.new(after) } unless element['after'].nil?
            Element.new(element)
          end
          Session.new(session)
        end
        report = Report.new(document)
        report.save
      end
    end
  end
end
