class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :cod_department

      t.timestamps
    end
    add_index :departments, :cod_department
  end
end
