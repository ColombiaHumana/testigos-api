class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.references :table, foreign_key: true
      t.references :user, foreign_key: true
      t.jsonb :votes

      t.timestamps
    end
  end
end
