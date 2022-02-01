class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable,
         :lockable
  has_many :roasters
  has_many :brews
  has_many :reviews
  has_many :inventories
  has_many :favourites
end
