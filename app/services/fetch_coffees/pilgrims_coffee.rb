module FetchCoffees
  class PilgrimsCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_url_root = 'https://www.pilgrimscoffee.com'
      coffee_index_url = '/collections/frontpage'
      coffee_css_on_index = '.prod-caption a'
      exclude_types = %w[tea sample gift]

      coffee_index_html = Net::HTTP.get_response(URI.parse(roaster_url_root + coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).each do |coffee_section|
        coffee = {}
        coffee['url'] = roaster_url_root + coffee_section[:href]
        next if exclude_types.any? { |s| coffee['url'].include? s }

        puts coffee['url']
        coffee_html = Net::HTTP.get_response(URI.parse(coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee['name'] = coffee_page.css('h1.product-title').text

        coffee_page.css('#product-description table tr').each do |row|
          if row.css('td').text.downcase.include? 'location'
            coffee['region'] = row.css('td').last.text
          elsif row.css('td').text.downcase.include? 'altitude'
            coffee['altitude'] = row.css('td').last.text.sub(/\n/, '').sub(/\s.+/, '')
          elsif row.css('td').text.downcase.include? 'owner'
            coffee['producer'] = row.css('td').last.text
          elsif row.css('td').text.downcase.include? 'process'
            coffee['process'] = row.css('td').last.text
          elsif %w[variety varietal].any? { |s| row.css('td').text.downcase.include? s }
            coffee['variety'] = row.css('td').last.text
          elsif row.css('td').text.downcase.include? 'taste'
            coffee['tasting_notes'] = row.css('td').last.text
          end
        end

        coffee['available'] = true

        @coffees << coffee
      end

      #puts @coffees.to_json
      @coffees
    end
  end
end
