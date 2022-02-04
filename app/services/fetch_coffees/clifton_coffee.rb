module FetchCoffees
  class CliftonCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_reference = "clifton_coffee"
      coffee_index_url = "https://cliftoncoffee.co.uk/product-category/coffee/"
      coffee_css_on_index = ".grid-item.gi-2x2 a"
      exclude_types = %w(coffee-bundles capsules)

      coffee_index_html = Net::HTTP.get_response(URI.parse(coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).each do |coffee_section|
        coffee = {}
        coffee["roaster_reference"] = roaster_reference
        coffee["url"] = coffee_section[:href]
        next if exclude_types.any? { |s| coffee["url"].include? s }

        puts coffee["url"]
        coffee_html = Net::HTTP.get_response(URI.parse(coffee["url"]))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee["country"] = coffee_page.css(".prod-name h1").text
        coffee["name"] = coffee_page.css(".prod-name h4").text
        coffee["tasting_notes"] = coffee_page.css(".tasting-nav-notes h3").text.gsub(" / ", ", ")
        coffee["description"] = coffee_page.css(".prod-description p").to_s

        coffee_page.css(".detail").each do |detail|
          if detail.css("h2").text.downcase.include?"region"
            coffee["region"] = detail.css("p").text
          elsif detail.css("h2").text.downcase.include?"altitude"
            coffee["altitude"] = detail.css("p").text.gsub(/\s.+/, '').gsub(/-.+/, '').gsub(',', '')
          elsif detail.css("h2").text.downcase.include?"producer"
            coffee["producer"] = detail.css("p").text
          elsif detail.css("h2").text.downcase.include?"process"
            coffee["process"] = detail.css("p").text
          elsif detail.css("h2").text.downcase.include?"variety"
            coffee["variety"] = detail.css("p").text
          elsif detail.css("h2").text.downcase.include?"farm"
            coffee["town"] = detail.css("p").text
          end
        end

        @coffees << coffee
      end

      @coffees
    end

  end
end
