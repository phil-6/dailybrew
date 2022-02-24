class CreateRoasters < ActiveRecord::Migration[7.0]
  def change
    create_table :roasters do |t|
      t.string :reference
      t.string :name
      t.text :description
      t.string :location
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :website
      t.string :twitter
      t.string :instagram
      t.string :facebook
      t.integer :coffees_count, null: false, default: 0
      t.integer :available_coffees_count, null: false, default: 0
      t.datetime :last_coffee_fetch

      t.timestamps
    end

    add_index :roasters, :website, unique: true
    add_index :roasters, :reference, unique: true
  end
end
