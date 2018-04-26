class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.string :name
      t.integer :cod_zone
      t.references :municipaly, foreign_key: true

      t.timestamps
    end
    add_index :zones, :cod_zone
  end
end
