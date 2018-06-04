class AddDefaultValueToRejected < ActiveRecord::Migration[5.2]
  def change
      change_column :users, :rejected, :boolean, default: false
  end
end
