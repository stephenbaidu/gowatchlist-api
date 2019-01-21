require 'rails_helper'

RSpec.describe SelectorFormatter do
  let(:selector) { '#w5-items\5b 0\5d > div:nth-child(3) > div.s-item__info.clearfix > a ' }
  let(:service) { SelectorFormatter.new(selector) }

  it 'creates dir' do
    expect(service.call).to eq('div > .s-item__info.clearfix > a')
  end
end
