class CreateTerrs < ActiveRecord::Migration[5.1]
  def change
    create_table :terrs do |t|
      t.string :name
      t.string :region
      t.date :datecomp
      t.string :notes
      t.text :history

      t.timestamps
    end
  end
end
