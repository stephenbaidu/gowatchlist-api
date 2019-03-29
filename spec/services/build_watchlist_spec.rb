require 'rails_helper'

RSpec.describe BuildWatchlist do
  let(:user) { create :user }
  let(:url) { 'https://www.example.com/listing' }
  let(:item_url) { "#{url}/1" }
  let(:css_selector) { 'div > a' }
  let(:params) do
    {
      name: 'Unique name',
      url: url,
      item_url: item_url,
    }
  end
  let(:service) { BuildWatchlist.new(user, params) }

  context 'when url is not valid' do
    before do
      allow(CssSelectorFromUrls).to receive(:call).with(url, item_url).and_return(css_selector)
    end

    let(:params) do
      super().tap { |param| param[:url] = '//invalid-url' }
    end

    it 'raises BuildWatchlist::InvalidUrlError' do
      expect { service.call }.to raise_error(BuildWatchlist::InvalidUrlError)
    end
  end

  context 'when item url is not found in page' do
    before do
      allow(CssSelectorFromUrls).to receive(:call).with(url, item_url).and_return(nil)
    end

    it 'raises BuildWatchlist::ItemNotFoundError' do
      expect { service.call }.to raise_error(BuildWatchlist::ItemNotFoundError)
    end
  end

  context 'when params are valid' do
    before do
      allow(CssSelectorFromUrls).to receive(:call).with(url, item_url).and_return(css_selector)
    end

    it 'builds a Watchlist object' do
      object = service.call
      expect(object.name).to eq('Unique name')
      expect(object.url).to eq(url)
      expect(object.selector).to eq(css_selector)
    end
  end
end
