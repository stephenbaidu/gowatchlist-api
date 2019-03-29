require 'rails_helper'

RSpec.describe ServiceBase do
  let(:service) { ServiceBase.new }

  describe '#call' do
    it 'raises NotImplementedError' do
      expect { service.call }.to raise_error(NotImplementedError)
    end
  end
end
