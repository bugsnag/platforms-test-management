# frozen_string_literal: true
require 'logger'

require_relative 'test_management_service/token_authenticator'
require_relative 'test_management_service/version'

require_relative 'test_management_service/account_manager/bitbar_account_manager'
require_relative 'test_management_service/account_manager/servlet'

require_relative 'test_management_service/test_reporter/report_handler'
require_relative 'test_management_service/test_reporter/servlet'

$logger = Logger.new(STDOUT, level: :info, datetime_format: '%Y-%m-%d %H:%M:%S')

ACCOUNT_MAXIMUM = ENV['BITBAR_ACCOUNT_MAX'].to_i

server = WEBrick::HTTPServer.new(:Port => 9340)
authenticator = TestManagementService::TokenAuthenticator.new

server.mount "/account",
             TestManagementService::AccountServlet,
             TestManagementService::BitbarAccountManager.new(ACCOUNT_MAXIMUM),
             authenticator

server.mount "/report",
             TestManagementService::ReportServlet,
             TestManagementService::TestReports::ReportHandler.new,
             authenticator

$logger.info('Starting test management server')
server.start

at_exit do
  $logger.warn('Stopping test management server')
  server.stop
end
