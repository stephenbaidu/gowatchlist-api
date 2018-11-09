class SixHoursWatchlistJob < ApplicationJob
  queue_as :watch_schedulers

  def perform(*args)
    Watchlist.ready_for_execution_with_wait_time(360).each do |watchlist|
      WatchlistJob.perform_later(watchlist.id)
    end
  end
end
