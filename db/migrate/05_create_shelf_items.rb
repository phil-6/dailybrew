class CreateShelfItems < ActiveRecord::Migration[7.0]
  def change
    create_table :shelf_items do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :coffee, null: false, foreign_key: true

      t.timestamps
    end

    add_index :shelf_items, %i[user_id coffee_id], unique: true
  end
end
