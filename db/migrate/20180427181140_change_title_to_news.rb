class ChangeTitleToNews < ActiveRecord::Migration[5.2]
  def change
    change_column :news, :title, :string, limit: 40
  end
end
