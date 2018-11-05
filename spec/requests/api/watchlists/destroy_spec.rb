require 'rails_helper'

describe 'DELETE /api/watchlists/:id' do
  let!(:user) { create :user }
  let!(:watchlist) { create :watchlist, user: user }
  let(:id) { watchlist.id }
  let(:headers) { authenticated_header(user) }
  let(:request) do
    delete "/api/watchlists/#{id}", headers: headers
  end

  it_behaves_like 'authenticated'

  context 'when watchlist id exists' do
    before { request }

    it { expect(response).to have_http_status(:no_content) }
    it { expect(response.body).to be_empty }
  end
end
