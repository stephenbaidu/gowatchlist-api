require 'rails_helper'

describe 'POST /api/refresh' do
  let(:user) { create :user }
  let(:access_cookie) { @tokens[:access] }
  let(:csrf_token) { @tokens[:csrf] }
  let(:headers) { { "#{JWTSessions.csrf_header}": csrf_token } }
  let(:request) do
    post '/api/refresh', params: {}, headers: headers
  end

  context 'success' do
    before do
      # set expiration time to 0 to create an already expired access token
      JWTSessions.access_exp_time = 0
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      @tokens = session.login
      JWTSessions.access_exp_time = 3600
      cookies[JWTSessions.access_cookie] = access_cookie

      request
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).not_to be_empty }
    it { expect(response_json.keys).to eq ['csrf'] }
    it { expect(response.cookies[JWTSessions.access_cookie]).to be_present }
  end

  context 'failure' do
    before do
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      @tokens = session.login

      request
    end

    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response.body).not_to be_empty }
    it { expect(response_json.keys).to eq ['error'] }
  end
end
