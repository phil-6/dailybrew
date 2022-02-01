class Roaster < ApplicationRecord
  belongs_to :user
  has_many :coffees
end
