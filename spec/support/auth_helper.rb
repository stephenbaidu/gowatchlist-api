module GowatchlistApi
  module AuthHelper
    def authenticated_header(user)
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      cookies[JWTSessions.access_cookie] = tokens[:access]

      {
        "#{JWTSessions.csrf_header}": tokens[:csrf],
        'Accept' => 'application/json'
      }
    end
  end
end

RSpec.configure do |config|
  config.include GowatchlistApi::AuthHelper
end
