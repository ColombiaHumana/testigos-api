class AddSampleToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :sample, :boolean, default: false, index: true
  end
end
