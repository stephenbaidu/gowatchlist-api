require 'rails_helper'

RSpec.describe CreateBrowser do
  let(:service) { CreateBrowser.new }

  before do
    allow(Watir::Browser).to receive(:new).and_return(nil)
  end

  describe '#call' do
    it 'calls CreateChromeUserDataDir service object' do
      user_data_dir_service = class_double(CreateChromeUserDataDir, call: '').as_stubbed_const
      expect(user_data_dir_service).to receive(:call)
      service.call
    end

    it 'calls CreateChromeUserDataDir service object' do
      user_data_dir_service = class_double(CreateChromeUserDataDir, call: '').as_stubbed_const
      expect(user_data_dir_service).to receive(:call)
      service.call
    end
  end
end
