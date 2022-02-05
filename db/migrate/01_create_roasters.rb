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

      t.timestamps
    end

    add_index :roasters, :website, unique: true
    add_index :roasters, :reference, unique: true
  end
end
