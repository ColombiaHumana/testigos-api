class AddGestionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gestion, :integer
  end
end
