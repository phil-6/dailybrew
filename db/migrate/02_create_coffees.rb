class CreateCoffees < ActiveRecord::Migration[7.0]
  def change
    create_table :coffees do |t|
      t.belongs_to :roaster, null: false, foreign_key: true
      t.string :name
      t.string :country
      t.string :region
      t.string :town
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :process
      t.integer :altitude
      t.string :variety
      t.string :tasting_notes
      t.string :producer
      t.text :description
      t.string :url, null: false
      t.boolean :available

      t.timestamps
    end

    add_index :coffees, :url, unique: true
    add_index :coffees, [:roaster_id, :name], unique: true
  end
end
