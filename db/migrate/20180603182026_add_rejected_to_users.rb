class AddRejectedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rejected, :boolean, dafault: false
  end
end
