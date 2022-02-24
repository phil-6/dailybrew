class Coffee < ApplicationRecord
  belongs_to :roaster
  counter_culture :roaster
  counter_culture :roaster, column_name: proc { |model| model.available? ? 'available_coffees_count' : nil }
  has_many :brews
  has_many :brewers, through: :brews, source: :user
  has_many :reviews
  has_many :shelf_items
  has_many :current_users, through: :shelf_items, source: :user
  has_many :favourites
  has_many :favourite_users, through: :favourites, source: :user

  validates_presence_of :roaster, :name, :country, :tasting_notes, :url
  validates :url, uniqueness: { case_sensitive: false }
  validates :name, uniqueness: { scope: :roaster }

  scope :available, -> { where(available: true) }
  scope :unavailable, -> { where(available: false) }

  def unique_brewers
    brewers.distinct
  end

  def unique_brewers_count
    unique_brewers.count
  end

  def average_brew_rating
    brews.average(:rating)&.round || '?'
  end
end
