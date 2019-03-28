require 'rails_helper'

RSpec.describe ElementValue do
  context 'when element has href value' do
    let(:url) { 'https://www.example.com/item-1' }

    it 'returns href' do
      element = instance_double('Nokogiri::XML::Element', attr: url)

      expect(element).to receive(:attr).with('href').and_return(url)
      expect(element).not_to receive(:content)

      service = ElementValue.new(element)
      service.call
    end
  end

  context 'when element has no href value' do
    let(:content) { 'Some content' }

    it 'returns content' do
      element = instance_double('Nokogiri::XML::Element', attr: nil, content: content)

      expect(element).to receive(:attr).with('href')
      expect(element).to receive(:content).and_return(content)

      service = ElementValue.new(element)
      service.call
    end
  end
end
