class Roaster < ApplicationRecord
  has_many :coffees

  validates_presence_of :reference, :name, :website
  validates :website, uniqueness: { case_sensitive: false }
  validates :reference , uniqueness: true

  def update_coffees
    UpdateCoffeesJob.perform_later(reference)
  end

end
