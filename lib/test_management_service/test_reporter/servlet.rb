# frozen_string_literal: true

require 'webrick'
require 'cgi'
require 'json'

module TestManagementService
  # Servlet controlling access to bitbar_account_manager methods
  class ReportServlet < WEBrick::HTTPServlet::AbstractServlet
    def initialize(server, report_handler)
      super server
      @report_handler = report_handler
    end

    def do_POST (request, response)
      begin
        report = JSON.parse(request.body)
        @report_handler.insert_report(report)
        response.status = 202
      rescue JSON::ParserError => e
        response.status = 400
        response.body = e.message
      rescue StandardError => e
        response.status = 503
        response.body = e.message
      end
    end
  end
end
