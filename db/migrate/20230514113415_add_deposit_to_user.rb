class AddDepositToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :total_deposit, :string
  end
end
