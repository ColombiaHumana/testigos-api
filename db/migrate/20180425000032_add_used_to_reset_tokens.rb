class AddUsedToResetTokens < ActiveRecord::Migration[5.2]
  def change
    add_column :reset_tokens, :used, :boolean, default: false
  end
end
