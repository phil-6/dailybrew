class ShelfItem < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :user
  counter_culture :coffee

  validates :coffee, uniqueness: { scope: :user_id }

  after_commit do
    broadcast_update_to(
      'shelf_items_count',
      target: "shelf_items_count_coffee_#{coffee.id}",
      html: ShelfItem.where(coffee:).count,
      locals: { coffee: }
    )
  end
end
