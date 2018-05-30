class AddNamesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :second_name, :string
    add_column :users, :surname, :string
    add_column :users, :second_surname, :string
  end
end
