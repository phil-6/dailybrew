class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :user
  counter_culture :coffee

  validates :coffee, uniqueness: { scope: :user_id }

  after_commit do
    broadcast_update_to(
      'favourites',
      partial: 'favourites/favourites_count',
      target: "favourites_count_coffee_#{coffee.id}",
      plain: Favourite.where(coffee: coffee).count,
      locals: { coffee: coffee }
    )
  end
end
