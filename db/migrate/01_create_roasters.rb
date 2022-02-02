class CreateRoasters < ActiveRecord::Migration[7.0]
  def change
    create_table :roasters, id: :string do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
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
  end
end
