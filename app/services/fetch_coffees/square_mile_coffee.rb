module FetchCoffees
  class SquareMileCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      coffee_index_url = "https://shop.squaremilecoffee.com/"
      coffee_css_on_index = "article.sqmile-product"
      exclude_types = %w(merchandise equipment subscription ale grinder exclude)

      coffee_index_html = Net::HTTP.get_response(URI.parse(coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).uniq.each do |coffee_section|
        coffee = {}
        coffee["url"] = "https://shop.squaremilecoffee.com#{coffee_section['data-product-url'] or '/exclude'}"
        next if exclude_types.any? { |s| coffee["url"].include? s }

        puts coffee["url"]
        coffee_html = Net::HTTP.get_response(URI.parse(coffee["url"]))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee["name"] = coffee_section['data-product-title']
        coffee["tasting_notes"] = coffee_page.css(".sqm-product-tasting-notes-pp").text.gsub('/ ', ', ').titleize
        coffee["tasting_notes"] = "Try it and find out!" if coffee["tasting_notes"] == ""

        coffee_page.css(".sqmile-single-product-column.sqmile-single-product-details p").each do |detail|
          if detail.text.downcase.include? "country"
            # For blends, squaremile lists multiple details
            if coffee["country"].nil?
              coffee["country"] = detail.css("b").text
            else
              coffee["country"] = "#{coffee['country']} & #{detail.css('b').text}"
            end
          elsif detail.css(".table-item-text").text.downcase.include? "region"
            if coffee["region"].nil?
              coffee["region"] = detail.css("b").text
            else
              coffee["region"] = "#{coffee['region']} & #{detail.css('b').text}"
            end
          elsif detail.css(".table-item-text").text.downcase.include? "process"
            if coffee["process"].nil?
              coffee["process"] = detail.css("b").text
            else
              coffee["process"] = "#{coffee['process']} & #{detail.css('b').text}"
            end
          elsif detail.css(".table-item-text").text.downcase.include? "producer"
            coffee["producer"] = detail.css("b").text
          elsif detail.css(".table-item-text").text.downcase.include? "altitude"
            coffee["altitude"] = detail.css("b").text.gsub(/\s.+/, '')
          elsif detail.css(".table-item-text").text.downcase.include? "variet"
            coffee["variety"] = detail.css("b").text
          end
        end

        # I hate this. Square Mile's descriptions have wildly inconsistent HTML
        if coffee_page.css(".sqmile-single-product-description p").text != ""
          coffee["description"] = coffee_page.at_css(".sqmile-single-product-description center").next
        else
          coffee["description"] = coffee_page.css(".sqmile-single-product-description p").text
        end

        @coffees << coffee
      end

      @coffees
    end

  end
end