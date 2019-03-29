module GowatchlistApi
  module AuthHelper
    def authenticated_header(user)
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      access_token, csrf_token = session.login.values_at(:access, :csrf)
      cookies[JWTSessions.access_cookie] = access_token

      {
        "#{JWTSessions.csrf_header}": csrf_token,
        'Accept' => 'application/json'
      }
    end
  end
end

RSpec.configure do |config|
  config.include GowatchlistApi::AuthHelper
end
