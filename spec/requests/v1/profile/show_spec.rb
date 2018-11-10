require 'rails_helper'

describe 'GET /v1/profile' do
  let(:user) { create :user }
  let(:headers) { authenticated_header(user) }
  let(:request) do
    get '/v1/profile', params: {}, headers: headers
  end

  it_behaves_like 'authenticated'

  context 'when params are valid' do
    before { request }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).not_to be_empty }
    it { expect(response_json.keys).to match_array(['id', 'name', 'email']) }
  end
end
