class CreateTerrouts < ActiveRecord::Migration[5.1]
  def change
    create_table :terrouts do |t|
      t.integer :terrid
      t.string :publisher
      t.date :dateout
      t.date :datedue

      t.timestamps
    end
  end
end
