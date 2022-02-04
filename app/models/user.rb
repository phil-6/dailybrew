class User < ApplicationRecord
  self.implicit_order_column = "created_at"
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable,
         :lockable
  has_many :roasters
  has_many :brews
  has_many :reviews
  has_many :inventories, dependent: :destroy
  has_many :favourites, dependent: :destroy

  validates_presence_of :first_name, :last_name, :terms
  validates :email, uniqueness: { case_sensitive: false }
  validates :terms, acceptance: true

end
