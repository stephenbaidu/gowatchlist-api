require 'rails_helper'

RSpec.describe WatchlistVisitor do
  before do
    allow_any_instance_of(ContentFetcher).to receive(:call).and_return([])
    allow_any_instance_of(UpdateVisit).to receive(:call).and_return(nil)
  end

  context 'when there is new content' do
    it 'triggers alert email' do
      visit_info = instance_double('VisitInfo', new_content?: true)
      watchlist = instance_double('Watchlist', visit_info: visit_info, url: '', selector: '')
      mailer = class_double(WatchlistMailer, alert: double(deliver_later: nil)).as_stubbed_const
      expect(mailer).to receive(:alert).with(watchlist)
      WatchlistVisitor.call(watchlist)
    end
  end
end
