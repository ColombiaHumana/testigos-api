class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.string :title, limit: 20
      t.string :content
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
