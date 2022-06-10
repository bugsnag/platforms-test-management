# frozen_string_literal: true

module TestManagementService
  class TokenAuthenticator
    def initialize
      @auth_token = ENV['TMS_AUTH_TOKEN']
    end

    def authenticate(req, res)
      token = req['authorization']
      if token.nil? || !token.eql?(@auth_token)
        reject(res)
        false
      else
        true
      end
    end

    def reject(res)
      $logger.warn('Attempt to access service with invalid authorization blocked')
      res.status = 401
      res.body = "User not valid"
    end
  end
end
