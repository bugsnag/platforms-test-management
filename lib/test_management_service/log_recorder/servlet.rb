# frozen_string_literal: true

require 'webrick'
require 'cgi'
require 'json'

module TestManagementService
  # Servlet controlling access to bitbar_account_manager methods
  class LogServlet < WEBrick::HTTPServlet::AbstractServlet
    def initialize(server, report_handler, authenticator)
      super server
      @report_handler = report_handler
      @authenticator = authenticator
    end

    def do_POST (request, response)
      return unless @authenticator.authenticate(request, response)
      begin
        pp "LOG LOG LOG"
        $logger.info('Received log from maze runner')
        report = JSON.parse(request.body)
        @report_handler.insert_log(report)
        response.status = 202
      rescue JSON::ParserError => e
        pp "PARSE FAILED"
        $logger.error("JSON.parse failed with error: #{e.message}")
        response.status = 400
        response.body = e.message
      rescue StandardError => e
        $logger.error("An error occurred: #{e.message}")
        response.status = 503
      end
    end
  end
end
