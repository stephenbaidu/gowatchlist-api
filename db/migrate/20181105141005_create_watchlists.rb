class CreateWatchlists < ActiveRecord::Migration[5.2]
  def change
    create_table :watchlists do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :selector, null: false
      t.integer :wait_time_in_minutes, default: 60
      t.datetime :expires_at
      t.references :user, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :watchlists, [:name, :user_id], unique: true, where: 'deleted_at IS NULL'
    add_index :watchlists, [:url, :user_id], unique: true, where: 'deleted_at IS NULL'
  end
end
