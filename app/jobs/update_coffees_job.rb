class UpdateCoffeesJob < ApplicationJob
  queue_as :default

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def perform(reference)

    roaster = Roaster.find_by reference: reference
    puts "#{roaster.name} has #{roaster.available_coffees_count} available coffees"
    roaster.available_coffees.each { |c| c.update_attribute(:available, false) }
    return unless (scraper = scraper(reference))

    coffees = scraper.new.scrape
    coffees.each do |coffee|
      begin
        this_coffee = roaster.coffees.find_or_create_by!(url: coffee['url']) do |new_coffee|
          new_coffee.name = coffee['name']
          new_coffee.country = coffee['country']
          new_coffee.tasting_notes = coffee['tasting_notes']
          new_coffee.available = coffee['available']
        end

        this_coffee.update!(coffee)
      end
    rescue ActiveRecord::RecordInvalid => invalid
      puts "Unable to save #{coffee['name']} because #{invalid.record&.errors&.messages} skipping"
      Rails.logger.error "Unable to save #{coffee['name']} because #{invalid.record&.errors&.messages} skipping"
      next
    end

    # not sure if this is the best place for this.
    # could be in an after_perform callback and could reach out to a method on the model
    # but its here for now.
    roaster.update!(last_coffee_fetch: DateTime.now)
  end

  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def scraper(reference)
    Object.const_get "FetchCoffees::#{reference.classify}"
  rescue NameError
    puts 'Scraper not found for this roaster'
  end
end
