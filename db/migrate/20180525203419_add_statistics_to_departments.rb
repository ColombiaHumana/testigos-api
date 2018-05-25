class AddStatisticsToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :weight, :float, precision: 15
    add_column :departments, :map, :string
  end
end
