class AddChildrenMemberToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :children_member, :integer
  end
end
