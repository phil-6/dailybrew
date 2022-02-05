class FetchCoffeesJob < ApplicationJob
  queue_as :default

  def perform(reference)
    # TODO Catch error when scraper doesnt exist
    scraper_class = Object.const_get "FetchCoffees::" + reference.classify

    scraper = scraper_class.new
    coffees = scraper.scrape

    roaster = Roaster.find_by reference: reference

    coffees.each do |coffee|
      this_coffee = roaster.coffees.find_or_create_by!(url: coffee["url"]) do |new_coffee|
        new_coffee.name = coffee["name"]
        new_coffee.country = coffee["country"]
        new_coffee.tasting_notes = coffee["tasting_notes"]
      end

      this_coffee.update(
        country: coffee["country"],
        tasting_notes: coffee["tasting_notes"],
        region: coffee["region"],
        town: coffee["town"],
        lat: coffee["lat"],
        lng: coffee["lng"],
        process: coffee["process"],
        altitude: coffee["altitude"],
        variety: coffee["variety"],
        producer: coffee["producer"],
        available: coffee["available"],
        description: coffee["description"]
      )
    end

  end
end
