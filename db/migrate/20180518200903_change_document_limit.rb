class ChangeDocumentLimit < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :document, :integer, limit: 8
  end
end
