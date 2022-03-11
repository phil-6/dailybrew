module FetchCoffees
  class HardLinesCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_url_root = 'https://hard-lines.co.uk'
      coffee_css_on_index = '.ProductList-item a'
      exclude_types = %w[pack coffeeclub tony gift kilo]

      coffee_index_html = Net::HTTP.get_response(URI.parse(roaster_url_root))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).uniq.each do |coffee_section|
        coffee = {}
        coffee['url'] = roaster_url_root + coffee_section[:href]

        next if exclude_types.any? { |s| coffee['url'].include? s }

        puts coffee['url']
        coffee_html = Net::HTTP.get_response(URI.parse(coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee['name'] = coffee_page.css('.ProductItem-details-title').first&.text
        coffee['country'] = coffee['name'].gsub(/ .*/, '') unless coffee['name']&.downcase.match? /blend|test/

        coffee_page.css('.ProductItem-details-excerpt p').each do |detail|
          if detail.text.downcase.include? 'notes: '
            coffee['tasting_notes'] = detail.text.gsub(/.*: /, '')
          elsif detail.text.downcase.include? 'producer: '
            coffee['producer'] = detail.text.gsub(/.*: /, '')
          elsif detail.text.downcase.include? 'country: '
            coffee['country'] = detail.text.gsub(/.*: /, '')
          elsif detail.text.downcase.include? 'region: '
            coffee['region'] = detail.text.gsub(/.*: /, '')
          elsif detail.text.downcase.include? 'process: '
            coffee['process'] = detail.text.gsub(/.*: /, '')
          elsif detail.text.downcase.include? 'variety: '
            coffee['variety'] = detail.text.gsub(/.*: /, '')
          elsif detail.text.downcase.include? 'altitude:'
            coffee['altitude'] = detail.text.gsub(/.*:( | )/, '').gsub(/-.*/, '').gsub(/ .*/, '').delete(',|m')
          end
        end
        coffee['tasting_notes'] = 'Try it and find out!' if coffee['tasting_notes'].nil?
        coffee['available'] = true

        @coffees << coffee
      end
      @coffees
    end
  end
end