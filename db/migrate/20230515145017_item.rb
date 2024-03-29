class Item < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :image
      t.string :name
      t.integer :quantity
      t.integer :minimum_bets
      t.string :state
      t.integer :batch_count
      t.datetime :start_at
      t.integer :status
      t.timestamps
    end
  end
end
