class WatchlistJob < ApplicationJob
  queue_as :watchers

  def perform(id)
    watchlist = Watchlist.find_by_id(id)
    return unless watchlist&.active?

    WatchlistHandler.call(watchlist)
  end
end
