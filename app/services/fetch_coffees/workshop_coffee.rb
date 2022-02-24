module FetchCoffees
  class WorkshopCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      coffee_index_url = 'https://workshopcoffee.com/collections/coffee'
      coffee_css_on_index = '.coffee-collection-item'
      exclude_types = %w[tasting-pack]

      coffee_index_html = Net::HTTP.get_response(URI.parse(coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).uniq.each do |coffee_section|
        coffee = {}
        coffee['url'] = 'https://workshopcoffee.com' + coffee_section.css('.first-button a')[0].attributes['href']
        next if exclude_types.any? { |s| coffee['url'].include? s }

        puts coffee['url']
        coffee_html = Net::HTTP.get_response(URI.parse(coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee['name'] = coffee_page.css('.product_name').text
        coffee['tasting_notes'] = coffee_page.css('.featured_text').text

        coffee_page.css('.extra-meta .technical .sub p').each do |detail|
          if detail.text.downcase.include? 'producer'
            coffee['producer'] = detail.css('span').text
          elsif detail.text.downcase.include? 'process'
            coffee['process'] = detail.css('span').text
          elsif detail.text.downcase.include? 'variety'
            coffee['variety'] = detail.css('span').text
          elsif detail.text.downcase.include? 'region'
            coffee['region'] = detail.css('span').text
          elsif detail.text.downcase.include? 'country'
            coffee['country'] = detail.css('span').text
          elsif detail.text.downcase.include? 'altitude'
            coffee['altitude'] = detail.css('span').text.gsub(/\s.+/, '').gsub(',', '')
          end
        end

        coffee['description'] = coffee_page.css('.hero-text').text + coffee_page.css('.moretext').text

        coffee['available'] = true

        @coffees << coffee
      end

      @coffees
    end
  end
end
