require 'rails_helper'

describe 'POST /v1/signin' do
  let(:password) { 'password' }
  let(:user) { create :user, password: password }
  let(:params) { { signin: { email: user.email, password: password } } }
  let(:request) do
    post '/v1/signin', params: params, headers: {}
  end

  context 'when credentials are valid' do
    before { request }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).not_to be_empty }
    it { expect(response_json.keys).to match_array(['csrf']) }
    it { expect(response.cookies[JWTSessions.access_cookie]).to be_present }
  end

  context 'when password is not valid' do
    let(:params) { super().tap { |rp| rp[:signin][:password] = 'incorrect' } }

    before { request }

    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response.body).not_to be_empty }
  end
end
