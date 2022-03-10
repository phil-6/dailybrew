module FetchCoffees
  class CoaltownCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      coffee_index_url = "https://www.coaltowncoffee.co.uk/sitemap_products_1.xml?from=3932265095&to=6698439966804"
      coffee_index_html = Net::HTTP.get_response(URI.parse(coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)
      exclude_types = %w[pack volume pod acaia nanopresso bambino barista oracle files guide grinder course enamel marmalade kit subscription v60 tea edo gift filter scale kettle tote latte mug cup set chocolate aeropress wilfa hario chemex opal mask fellow bible magazine breakfast tshirt t-shirt chai cafetiere soap mahcine]

      coffee_index_page.xpath("//loc").each do |xml_url|
        coffee = {}
        coffee['url'] = xml_url.text
        next if exclude_types.any? { |s| coffee['url'].include? s }

        coffee_html = Net::HTTP.get_response(URI.parse(coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee['tasting_notes'] = coffee_page.at('h3:contains("taste notes")')&.parent&.parent&.next_element&.css('p')&.text
        puts "Visited but skipped: #{coffee['url']}, as could not find tasting notes" if coffee['tasting_notes'].nil?
        next if coffee['tasting_notes'].nil?

        puts coffee['url']
        coffee['name'] = coffee_page.css('h1.ProductMeta__Title').text
        coffee['tasting_notes']
        coffee['producer'] = coffee_page.at('h3:contains("producer")')&.text&.gsub(/producer: |producers: /, '')&.strip
        coffee['available'] = true

        @coffees << coffee
      end

      @coffees
    end
  end
end
