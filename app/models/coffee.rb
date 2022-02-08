class Coffee < ApplicationRecord
  belongs_to :roaster
  has_many :brews
  has_many :reviews
  has_many :inventories
  has_many :favourites

  validates_presence_of :roaster, :name, :country, :tasting_notes, :url
  validates :url, uniqueness: { case_sensitive: false }
  validates :name, uniqueness: { scope: [:roaster] }
end
