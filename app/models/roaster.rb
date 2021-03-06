class Roaster < ApplicationRecord
  has_many :coffees
  validates_presence_of :reference, :name, :website
  validates :website, uniqueness: { case_sensitive: false }
  validates :reference, uniqueness: true

  scope :with_coffees, -> { joins(:coffees).distinct }

  def update_coffees
    UpdateCoffeesJob.perform_later(reference)
  end

  def available_coffees
    coffees.available
  end

  after_update_commit do
    broadcast_prepend_later_to(
      'roaster_updates',
      target: 'async_output',
      partial: 'roasters/update_summary',
      locals: { roaster: self }
    )
  end
end
