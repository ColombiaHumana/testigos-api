class AddOrderToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :order, :integer
  end
end
