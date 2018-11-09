class WatchlistSchedulerJob < ApplicationJob
  queue_as :watch_schedulers

  def perform(*args)
    Watchlist.ready_for_execution.each do |watchlist|
      WatchlistJob.perform_later(watchlist.id)
    end
  end
end
