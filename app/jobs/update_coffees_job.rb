class UpdateCoffeesJob < ApplicationJob
  queue_as :default

  rescue_from NameError do
    puts "Scraper not found for this roaster"
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def perform(reference)
    # TODO: Catch error when scraper doesnt exist
    scraper = Object.const_get "FetchCoffees::#{reference.classify}"

    coffees = scraper.new.scrape
    roaster = Roaster.find_by reference: reference

    coffees.each do |coffee|
      this_coffee = roaster.coffees.find_or_create_by!(url: coffee['url']) do |new_coffee|
        new_coffee.name = coffee['name']
        new_coffee.country = coffee['country']
        new_coffee.tasting_notes = coffee['tasting_notes']
      end

      this_coffee.update!(coffee)
    end

    # not sure if this is the best place for this.
    # could be in an after_perform callback and could reach out to a method on the model
    # but its here for now.
    roaster.update!(last_coffee_fetch: DateTime.now)
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
end
