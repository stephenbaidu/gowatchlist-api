class AddActiveToWatchlists < ActiveRecord::Migration[5.2]
  def change
    add_column :watchlists, :active, :boolean, default: false
  end
end
