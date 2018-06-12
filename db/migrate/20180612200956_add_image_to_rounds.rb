class AddImageToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :image, :string
  end
end
