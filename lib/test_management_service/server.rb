# frozen_string_literal: true

require 'webrick'
require 'cgi'
require 'json'

module TestManagementService
  # Servlet controlling access to bitbar_account_manager methods
  class AccountServlet < WEBrick::HTTPServlet::AbstractServlet
    def initialize(server, account_manager)
      super server
      @account_manager = account_manager
    end

    # Denotes two routes:
    #   /request - Attempt to claim an open account
    #   /release - Release a currently used account
    def do_GET (request, response)
      case request.path_info
      when "/request"
        account = @account_manager.claim_account
        if account.nil?
          response.status = 409
          response.body = 'No account currently available'
        else
          response.status = 200
          response.header['content-type'] = 'application/json'
          response.body = JSON.dump(account)
        end
      when "/release"
        query_string = CGI.parse(request.query_string)
        pp query_string
        @account_manager.release_account(query_string['account_id'].first.to_i)
        response.status = 202
      else
        response.status = 404
        response.body = "Path #{request.path} not found"
      end
    end
  end
end