# frozen_string_literal: true
require_relative 'test_management_service/version'

require_relative 'test_management_service/account_manager/bitbar_account_manager'
require_relative 'test_management_service/account_manager/servlet'

require_relative 'test_management_service/test_reporter/report_handler'
require_relative 'test_management_service/test_reporter/servlet'

ACCOUNT_MAXIMUM = ENV['BITBAR_ACCOUNT_MAX'].to_i

server = WEBrick::HTTPServer.new(:Port => 9340)

server.mount "/account",
             TestManagementService::AccountServlet,
             TestManagementService::BitbarAccountManager.new(ACCOUNT_MAXIMUM)

server.mount "/report",
             TestManagementService::ReportServlet,
             TestManagementService::TestReports::ReportHandler.new

server.start

at_exit do
  server.stop
end
