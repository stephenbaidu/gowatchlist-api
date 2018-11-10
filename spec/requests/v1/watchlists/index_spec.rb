require 'rails_helper'

describe 'GET /v1/watchlists' do
  let!(:user) { create :user }
  let!(:watchlists) { create_list :watchlist, 2, user: user }
  let(:headers) { authenticated_header(user) }
  let(:request) do
    get '/v1/watchlists', headers: headers
  end

  it_behaves_like 'authenticated'

  before { request }

  it { expect(response).to have_http_status(:ok) }
  it { expect(response.body).not_to be_empty }
  it { expect(response_json.count).to eq(2) }
end
