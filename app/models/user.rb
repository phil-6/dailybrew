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

  validates_presence_of :email, :username, :password
  validates :email, uniqueness: { case_sensitive: false }

  def display_name
    username || first_name
  end
end
