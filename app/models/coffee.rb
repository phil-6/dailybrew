class Coffee < ApplicationRecord
  belongs_to :roaster
  has_many :brews
  has_many :reviews
  has_many :inventories
  has_many :favourites
end
