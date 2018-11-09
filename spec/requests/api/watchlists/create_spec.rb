require 'rails_helper'

describe 'POST /api/watchlists' do
  let(:user) { create :user }
  let(:watchlist) { build :watchlist, user: user }
  let(:params) do
    { watchlist: watchlist.slice(:name, :url, :selector) }
  end
  let(:headers) { authenticated_header(user) }
  let(:request) do
    post '/api/watchlists', params: params, headers: headers
  end

  it_behaves_like 'authenticated'

  context 'when params are valid' do
    before { request }

    it { expect(response).to have_http_status(:created) }
    it { expect(response.body).not_to be_empty }
  end

  context 'when a parameter is missing' do
    let(:params) { super().tap { |rp| rp[:watchlist][:name] = '' } }

    before { request }

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it { expect(response.body).not_to be_empty }
  end
end
