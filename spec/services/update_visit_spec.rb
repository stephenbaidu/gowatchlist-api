require 'rails_helper'

RSpec.describe UpdateVisit do
  let!(:visit_info) { create :visit_info }
  let(:service) { UpdateVisit.new(visit_info, []) }

  describe '#call' do
    it 'calls update_visit and save on visit_info' do
      expect(visit_info).to receive(:update_visit)
      expect(visit_info).to receive(:save)
      service.call
    end
  end
end
