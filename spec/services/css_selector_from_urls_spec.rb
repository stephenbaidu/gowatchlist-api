require 'rails_helper'

RSpec.describe CssSelectorFromUrls do
  let(:site_url) { 'https://www.example.com' }
  let(:item_url) { 'https://www.example.com/item-1' }
  let(:raw_html) do
    %(
      <a href="https://www.example.com/item-1"></a>
      <a href="https://www.example.com/item-2"></a>
    )
  end
  let(:html) { Nokogiri::HTML(raw_html) }
  let!(:service) { CssSelectorFromUrls.new(site_url, item_url) }

  before do
    allow(PageHtml).to receive(:call).and_return(html)
  end

  context 'when html is empty' do
    it 'returns empty string' do
      expect(service.call).to eq('html > body > a:nth-of-type(1)')
    end
  end
end
