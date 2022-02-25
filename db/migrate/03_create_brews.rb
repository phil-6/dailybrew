class CreateBrews < ActiveRecord::Migration[7.0]
  def change
    create_table :brews do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :coffee, null: false, foreign_key: true
      t.string :equipment
      t.string :method
      t.integer :coffee_weight
      t.integer :water_weight
      t.string :grinder
      t.string :grinder_setting
      t.integer :time, default: 0
      t.text :notes
      t.integer :rating
      t.boolean :public, null: false, default: true

      t.timestamps
    end
  end
end
