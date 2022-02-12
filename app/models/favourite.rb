class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :coffee
end
