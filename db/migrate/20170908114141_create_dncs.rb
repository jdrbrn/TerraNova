class CreateDncs < ActiveRecord::Migration[5.1]
  def change
    create_table :dncs do |t|
      t.integer :terrid
      t.string :number
      t.string :street
      t.string :name
      t.string :publisher
      t.date :date
      t.string :notes

      t.timestamps
    end
  end
end
