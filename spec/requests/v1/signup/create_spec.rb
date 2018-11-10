require 'rails_helper'

describe 'POST /v1/signup' do
  let(:params) do
    {
      signup: {
        name: 'John Doe',
        email: 'john.doe@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end
  let(:request) do
    post '/v1/signup', params: params, headers: {}
  end

  context 'when params are valid' do
    before { request }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).not_to be_empty }
    it { expect(response_json.keys).to match_array(['csrf']) }
    it { expect(response.cookies[JWTSessions.access_cookie]).to be_present }
  end

  context 'creates a user' do
    it { expect { request }.to change(User, :count).by(1) }
  end

  context 'when a required param is missing' do
    let(:params) { super().tap { |rp| rp[:signup][:email] = '' } }

    before { request }

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it { expect(response.body).not_to be_empty }
  end
end
