require 'rails_helper'

RSpec.describe ExtractAnchorElements do
  let(:raw_html) do
    %(
      <a href="https://www.example.com/item-1" class="link"></a>
      <a href="https://www.example.com/item-2" class="link"></a>
      <div class="link">https://www.example.com/item-3</div>
    )
  end
  let(:html) { Nokogiri::HTML(raw_html) }
  let(:service) { ExtractAnchorElements.new(html) }

  it 'creates dir' do
    expect(service.call.count).to eq(2)
  end
end
