class AddRoleToPanelUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :panel_users, :role, :string, default: 'callcenter'
  end
end
