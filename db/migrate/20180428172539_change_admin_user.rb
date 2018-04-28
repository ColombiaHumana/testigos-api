class ChangeAdminUser < ActiveRecord::Migration[5.2]
  def change
    change_column :admin_users, :role, :string, limit: 20, default: "lector"
  end
end
