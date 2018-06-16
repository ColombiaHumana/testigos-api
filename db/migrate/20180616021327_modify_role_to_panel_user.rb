class ModifyRoleToPanelUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :panel_users, :role, :string
    add_column :panel_users, :role, :integer, default: 1
  end
end
