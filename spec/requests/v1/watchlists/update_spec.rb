require 'rails_helper'

describe 'PUT /v1/watchlists/:id' do
  let!(:user) { create :user }
  let!(:watchlist) { create :watchlist, user: user }
  let(:id) { watchlist.id }
  let(:params) { {} }
  let(:headers) { authenticated_header(user) }
  let(:request) do
    put "/v1/watchlists/#{id}", params: params, headers: headers
  end

  it_behaves_like 'authenticated'

  context 'when params are valid' do
    let(:new_name) { 'Another name' }
    let(:params) do
      { watchlist: { name: new_name } }
    end

    before { request }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).not_to be_empty }
    it { expect(response_json['name']).to eq(new_name) }
  end
end
