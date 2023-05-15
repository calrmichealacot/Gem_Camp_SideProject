class Genre < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :genre, :integer
  end
end
