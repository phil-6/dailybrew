class ShelfItem < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :user
  counter_culture :coffee

  validates :coffee, uniqueness: {scope: :user_id}
end
