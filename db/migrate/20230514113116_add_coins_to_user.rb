class AddCoinsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :coins,:decimal ,precision: 18, scale: 2, default: "0.0"
  end
end
