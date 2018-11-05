class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :users, :email, unique: true, where: 'deleted_at IS NULL'
  end
end
