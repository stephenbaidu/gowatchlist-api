class CreateVisitInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_infos do |t|
      t.references :watchlist, foreign_key: true, null: false
      t.text :previous_content, array: true, default: []
      t.text :current_content, array: true, default: []
      t.integer :visits, default: 0
      t.integer :alerts, default: 0

      t.timestamps
    end
  end
end
