class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.integer :cod_post
      t.references :zone, foreign_key: true
      t.integer :males
      t.integer :females
      t.string :address

      t.timestamps
    end
    add_index :posts, :cod_post
  end
end
