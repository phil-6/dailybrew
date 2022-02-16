class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :user
  counter_culture :coffee

  validates :coffee, uniqueness: { scope: :user_id }

  after_commit do
    broadcast_update_to(
      'favourites_count',
      target: "favourites_count_coffee_#{coffee.id}",
      html: Favourite.where(coffee:).count,
      locals: { coffee: }
    )
  end
end
