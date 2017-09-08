class CreateTerrins < ActiveRecord::Migration[5.1]
  def change
    create_table :terrins do |t|
      t.integer :terrid

      t.timestamps
    end
  end
end
