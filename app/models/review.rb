class Review < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :coffee
  counter_culture :coffee, column_name: proc {|model| model.public? ? 'public_reviews_count' : nil}
end
