class WatchlistSchedulerJob < ApplicationJob
  def perform(*args)
    Watchlist.ready_for_execution.each do |watchlist|
      WatchlistJob.perform_later(watchlist.id)
    end
  end
end
