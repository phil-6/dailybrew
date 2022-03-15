class Brew < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  counter_culture :user
  counter_culture :user, column_name: proc { |model| model.public? ? 'public_brews_count' : nil }
  counter_culture :coffee
  counter_culture :coffee, column_name: proc { |model| model.public? ? 'public_brews_count' : nil }

  scope :visible, -> { where(public: true) }
  scope :today, -> { where('created_at >= ?', Time.now.beginning_of_day) }
  scope :this_week, -> { where('created_at >= ?', 1.week.ago) }
  # scope :daily_brewers

  after_create_commit do
    if public
      broadcast_prepend_to(
        'recent_brews',
        target: 'brews_table',
        locals: { brew: self },
        partial: 'brews/brews_table_row'
      )
    end
    broadcast_update_later_to(
      'brews_count',
      target: "brews_count_coffee_#{coffee.id}",
      html: Brew.where(coffee:).count,
      locals: { coffee: }
    )
    broadcast_update_later_to(
      'brewers_count',
      target: "brewers_count_coffee_#{coffee.id}",
      html: coffee.unique_brewers_count,
      locals: { coffee: }
    )
    broadcast_update_later_to(
      'daily_brewers_count',
      target: 'daily_brewers',
      html: ActionController::Base.helpers.pluralize(User.daily_brewers.count, 'user has', plural: 'users have')
    )
    broadcast_update_later_to(
      'daily_brews_count',
      target: 'daily_brews',
      html: ActionController::Base.helpers.pluralize(Brew.today.count, 'coffee')
    )
  end

  def formatted_time
    return unless time

    mins = time / 60
    secs = time - (mins * 60)
    format('%<mins>02d:%<secs>02d', { mins:, secs:, ms: 0 })
  end
end
