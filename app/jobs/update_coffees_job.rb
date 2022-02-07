class UpdateCoffeesJob < ApplicationJob
  queue_as :default

  def perform(reference)
    # TODO Catch error when scraper doesnt exist
    scraper = Object.const_get "FetchCoffees::" + reference.classify

    coffees = scraper.new.scrape
    roaster = Roaster.find_by reference: reference

    coffees.each do |coffee|
      this_coffee = roaster.coffees.find_or_create_by!(url: coffee["url"]) do |new_coffee|
        new_coffee.name = coffee["name"]
        new_coffee.country = coffee["country"]
        new_coffee.tasting_notes = coffee["tasting_notes"]
      end

      this_coffee.update!(coffee)
    end

  end
end
