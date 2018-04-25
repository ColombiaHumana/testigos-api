class CreateResetTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :reset_tokens do |t|
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :reset_tokens, :token, unique: true
  end
end
