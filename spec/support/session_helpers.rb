module Helpers
  def session_auth_header(session)
    { 'Content-Type' => 'application/json',
      #'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(s.key.key) }
      'HTTP_AUTHORIZATION' => "Token token=\"#{session.key.key}\""
    }
  end

  def json_request_header
    { 'Content-Type' => 'application/json',
      Accept: 'application/json'
    }
  end
end