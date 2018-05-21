class AddCoordinatorToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :coordinator_id, :integer, index: true
    add_foreign_key :posts, :users, column: :coordinator_id
  end
end
