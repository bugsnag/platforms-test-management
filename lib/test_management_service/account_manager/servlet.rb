# frozen_string_literal: true

require 'webrick'
require 'cgi'
require 'json'

module TestManagementService
  # Servlet controlling access to bitbar_account_manager methods
  class AccountServlet < WEBrick::HTTPServlet::AbstractServlet
    def initialize(server, account_manager, authenticator)
      super server
      @account_manager = account_manager
      @authenticator = authenticator
    end

    # Denotes two routes:
    #   /request - Attempt to claim an open account
    #   /release - Release a currently used account
    def do_GET (request, response)
      return unless @authenticator.authenticate(request, response)
      case request.path_info
      when '/request'
        $logger.info('Received request for account')
        account = @account_manager.claim_account
        if account.nil?
          $logger.warn('Responding with 409 - No accounts currently available')
          response.status = 409
          response.body = 'No account currently available'
        else
          $logger.info("Assigned account #{account}")
          response.status = 200
          response.header['content-type'] = 'application/json'
          response.body = JSON.dump(account)
        end
      when '/release'
        query_string = CGI.parse(request.query_string)
        if query_string.keys.include?('account_id')
          account_id = query_string['account_id'].first.to_i
          $logger.info("Received release request for account #{account_id}")
          # account_id is 0 only if the string could not be converted into a number
          # There is no account 0 so we can discard that
          if account_id.zero?
            $logger.warn('Account ID invalid')
            response.status = 400
          else
            @account_manager.release_account(account_id)
            $logger.info('Account release successful')
            response.status = 202
          end
        else
          $logger.warn('account_id query string not present')
          response.status = 400
        end
      else
        $logger.warn("Invalid attempt to access: #{request.path}")
        response.status = 404
        response.body = "Path #{request.path} not found"
      end
    end
  end
end