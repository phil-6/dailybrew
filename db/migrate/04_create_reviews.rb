class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :coffee, null: false, foreign_key: true
      t.integer :rating
      t.text :content
      t.boolean :public, null: false, default: true

      t.timestamps
    end
  end
end
