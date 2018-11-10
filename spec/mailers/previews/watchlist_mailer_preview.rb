# Preview all emails at http://localhost:3000/rails/mailers/watchlist_mailer
class WatchlistMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/watchlist_mailer/alert
  def alert
    WatchlistMailerMailer.alert
  end

end
