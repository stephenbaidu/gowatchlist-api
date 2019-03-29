require 'rails_helper'

describe 'POST /v1/watchlists' do
  let!(:user) { create :user }
  let!(:watchlist) { build :watchlist, user: user }
  let(:url) { watchlist.url }
  let(:item_url) { '/an-item' }
  let(:params) do
    {
      watchlist: {
        name: watchlist.name,
        url:  url,
        item_url: item_url
      }
    }
  end
  let(:headers) { authenticated_header(user) }
  let(:request) do
    post '/v1/watchlists', params: params, headers: headers
  end

  before do
    allow(CssSelectorFromUrls).to receive(:call).with(url, item_url).and_return('some selector')
  end

  it_behaves_like 'authenticated'

  context 'when params are valid' do
    before { request }

    it { expect(response).to have_http_status(:created) }
    it { expect(response.body).not_to be_empty }
  end

  context 'when url is not valid' do
    before do
      allow_any_instance_of(BuildWatchlist).to receive(:call).and_raise(BuildWatchlist::InvalidUrlError)
      request
    end

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it { expect(response.body).not_to be_empty }
  end

  context 'when item is not on page' do
    before do
      allow_any_instance_of(BuildWatchlist).to receive(:call).and_raise(BuildWatchlist::ItemNotFoundError)
      request
    end

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it { expect(response.body).not_to be_empty }
  end

  context 'when a parameter is missing' do
    let(:params) { super().tap { |rp| rp[:watchlist][:name] = '' } }

    before { request }

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it { expect(response.body).not_to be_empty }
  end
end
