class AddPostToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :post, foreign_key: true
  end
end
