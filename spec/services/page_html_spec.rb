require 'rails_helper'

RSpec.describe PageHtml do
  let(:service) { PageHtml.new(nil) }

  describe '#call' do
    it 'calls goto, html and close on browser' do
      browser = instance_double('Watir::Browser', goto: nil, html: nil, close: nil)
      user_data_dir_service = class_double(CreateBrowser, call: browser).as_stubbed_const
      expect(browser).to receive(:goto)
      expect(browser).to receive(:html)
      expect(browser).to receive(:close)
      service.call
    end
  end
end
