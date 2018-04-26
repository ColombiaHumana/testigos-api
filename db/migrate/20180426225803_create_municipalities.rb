class CreateMunicipalities < ActiveRecord::Migration[5.2]
  def change
    create_table :municipalities do |t|
      t.string :name
      t.integer :cod_municipaly
      t.references :department, foreign_key: true

      t.timestamps
    end
    add_index :municipalities, :cod_municipaly
  end
end
