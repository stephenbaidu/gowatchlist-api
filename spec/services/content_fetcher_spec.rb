require 'rails_helper'

# Redefine PageBrowser class so as not to trigger chrome requirement
class PageBrowser
  def initialize
  end
end

RSpec.describe ContentFetcher do
  let(:url) { 'https://www.example.com' }
  let(:css_selector) { '.link' }
  let(:html) { Nokogiri::HTML(nil) }
  let!(:service) { ContentFetcher.new(url, css_selector) }

  before do
    allow_any_instance_of(PageHtml).to receive(:call).and_return(html)
  end

  context 'when html is empty' do
    it 'returns empty array' do
      expect(service.call).to eq([])
    end
  end

  context 'when html is returned' do
    let(:raw_html) do
      %{
        <a href="https://www.example.com/item-1" class="link"></a>
        <a href="https://www.example.com/item-2" class="link"></a>
        <div class="link">https://www.example.com/item-3</div>
      }
    end
    let(:html) { Nokogiri::HTML(raw_html) }
    
    it 'returns list of hrefs or content' do
      list = [
        'https://www.example.com/item-1',
        'https://www.example.com/item-2',
        'https://www.example.com/item-3',
      ]
      expect(service.call).to match_array(list)
    end
  end
end
