module FetchCoffees
  class Hasbean
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_reference ="hasbean"
      coffee_index_url = "https://www.hasbean.co.uk/collections/coffee"
      coffee_css_on_index = ".grid-link"
      exclude_types = %w(blend)

      coffee_index_html = Net::HTTP.get_response(URI.parse(coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).each do |coffee_section|
        coffee = {}
        coffee["roaster_reference"] = roaster_reference
        coffee["url"] = "https://www.hasbean.co.uk/" + coffee_section[:href]
        next if exclude_types.any? { |s| coffee["url"].include? s }

        puts coffee["url"]
        coffee_html = Net::HTTP.get_response(URI.parse(coffee["url"]))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee_json_raw = coffee_page.css('#ProductJson-product-template').text
        coffee_json = JSON.parse(coffee_json_raw)

        coffee["country"] = coffee_json["vendor"]
        coffee["name"] = coffee_json["title"]
        coffee["tasting_notes"] = coffee_page.css('.section-header p.h2').text
        coffee["description"] = coffee_page.css(".prod-description p").text

        coffee_page.css('#full-product-description ul li').each do |detail|
          if detail.css("h2").text.downcase.include?"region"
            coffee["region"] = detail.text.gsub('Region: ', '')
          elsif detail.css("h2").text.downcase.include?"altitude"
            coffee["altitude"] = detail.text.gsub('Altitude: ', '').gsub(/\s.+|,|-.+|–.+/, '')
          elsif detail.css("h2").text.downcase.include?"producer"
            coffee["producer"] = detail.text.gsub('Producer: ', '')
          elsif detail.css("h2").text.downcase.include?"process"
            coffee["process"] = detail.text.gsub('Processing system:', '').gsub('Processing method:', '')
          elsif detail.text.downcase.include?"varietal"
            coffee["variety"] = detail.text.gsub('Varietal:', '')
          elsif detail.css("h2").text.downcase.include?"farm"
            coffee["town"] = detail.text.gsub('Micro region: ', '')
          end
        end

        @coffees << coffee
      end

      @coffees
    end

  end
end