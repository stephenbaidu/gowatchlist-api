require 'rails_helper'

describe 'GET /v1/watchlists/:id' do
  let!(:user) { create :user }
  let!(:watchlist) { create :watchlist, user: user }
  let(:id) { watchlist.id }
  let(:headers) { authenticated_header(user) }
  let(:request) do
    get "/v1/watchlists/#{id}", headers: headers
  end

  it_behaves_like 'authenticated'

  context 'when watchlist id exists' do
    before { request }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).not_to be_empty }
    it { expect(response_json['id']).to eq(watchlist.id) }
    it 'has all the fields' do
      keys = %w[
        id
        name
        url
        selector
        active
        expires_at
        visits
        alerts
        created_at
        updated_at
      ]
      expect(response_json.keys).to match_array(keys)
    end
  end

  context 'when watchlist id does not exist' do
    let(:id) { '99999999999999' }

    before { request }

    it { expect(response).to have_http_status(:not_found) }
    it { expect(response.body).to be_empty }
  end
end
