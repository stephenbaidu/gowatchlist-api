require 'rails_helper'

RSpec.describe WatchlistMailer, type: :mailer do
  describe 'alert' do
    let(:user) { create :user }
    let(:watchlist) { create :watchlist, user: user }
    let(:mail) { WatchlistMailer.alert(watchlist) }

    it 'renders the headers' do
      expect(mail.subject).to eq('[GoWatchlist] Watchlist Updated')
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Your watchlist')
    end
  end
end
