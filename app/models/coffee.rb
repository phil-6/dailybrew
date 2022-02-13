class Coffee < ApplicationRecord
  belongs_to :roaster
  counter_culture :roaster
  counter_culture :roaster, column_name: proc { |model| model.available? ? 'available_coffees_count' : nil }
  has_many :brews
  has_many :reviews
  has_many :inventories
  has_many :favourites

  validates_presence_of :roaster, :name, :country, :tasting_notes, :url
  validates :url, uniqueness: { case_sensitive: false }
  validates :name, uniqueness: { scope: [:roaster] }

  scope :available, -> { where(available: true) }
  scope :unavailable, -> { where(available: false) }
end
