class AddImageToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :image, :string
  end
end
