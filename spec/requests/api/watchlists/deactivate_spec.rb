require 'rails_helper'

describe 'POST /api/watchlists/:id' do
  let!(:user) { create :user }
  let!(:watchlist) { create :watchlist, user: user, active: true }
  let(:id) { watchlist.id }
  let(:headers) { authenticated_header(user) }
  let(:request) do
    post "/api/watchlists/#{id}/deactivate", params: {}, headers: headers
  end

  it_behaves_like 'authenticated'

  context 'when deactivating a watchlist' do
    before { request }

    it { expect(response).to have_http_status(:ok) }
    it { expect(watchlist.reload.active).to eq(false) }
  end
end
