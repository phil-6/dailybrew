class User < ApplicationRecord
  self.implicit_order_column = 'created_at'
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable,
         :lockable
  has_many :brews
  has_many :brewed_coffees, through: :brews, source: :coffee
  has_many :reviews
  has_many :shelf_items, dependent: :destroy
  has_many :shelf_coffees, through: :shelf_items, source: :coffee
  has_many :favourites, dependent: :destroy
  has_many :favourite_coffees, through: :favourites, source: :coffee

  validates_presence_of :email
  validates :email, uniqueness: { case_sensitive: false }

  scope :daily_brewers, -> { joins(:brews).where('brews.created_at > ?', Time.now.beginning_of_day).distinct }

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    username || first_name
  end

  def unique_brewed_coffees
    brewed_coffees.distinct
  end

  def unique_brewed_coffees_count
    unique_brewed_coffees.count
  end

  def average_brew_rating(coffee)
    brews.where(coffee:).average(:rating)&.round || '?'
  end
end
