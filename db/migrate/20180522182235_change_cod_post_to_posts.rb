class ChangeCodPostToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :cod_post, :string
  end
end
