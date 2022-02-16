class Brew < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :user
  counter_culture :user, column_name: proc { |model| model.public? ? 'public_brews_count' : nil }
  counter_culture :coffee
  counter_culture :coffee, column_name: proc { |model| model.public? ? 'public_brews_count' : nil }

  scope :visible, -> { where(public: true) }

  after_create_commit do
    if public
      broadcast_prepend_to(
        'recent_brews',
        target: "brews_coffee_#{coffee.id}",
        locals: { brew: self }
      )
    end
  end
end
