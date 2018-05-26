class AddCelagToDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :scrutinized, :integer, default: 0
    add_column :departments, :percentage, :float, default: 1.0
    add_column :departments, :coefficient, :float, default: 1.0
  end
end
