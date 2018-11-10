class WatchlistMailer < ApplicationMailer
  def alert(watchlist)
    @watchlist = watchlist
    @user = watchlist.user

    subject = '[GoWatchlist] Watchlist Updated'
    mail to: @user.email, subject: subject
  end
end
