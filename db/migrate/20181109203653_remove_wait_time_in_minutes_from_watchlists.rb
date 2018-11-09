class RemoveWaitTimeInMinutesFromWatchlists < ActiveRecord::Migration[5.2]
  def change
    remove_column :watchlists, :wait_time_in_minutes, :integer
  end
end
