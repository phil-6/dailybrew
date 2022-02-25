module FetchCoffees
  class UeCoffeeRoaster
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_url_root = 'https://uecoffeeroasters.com/'
      coffee_index_url = 'collections/all-coffee'
      coffee_css_on_index = '.product-block a.caption'
      exclude_types = %w[]

      coffee_index_html = Net::HTTP.get_response(URI.parse(roaster_url_root + coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).each do |coffee_section|
        coffee = {}
        puts coffee['url'] = coffee_section[:href]
        next if exclude_types.any? { |s| coffee['url'].include? s }

        coffee_html = Net::HTTP.get_response(URI.parse(roaster_url_root + coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)
        coffee['name'] = coffee_page.css('.product-area__details__title').text
        coffee_description_section = coffee_page.css('.shg-c')

        coffee_description_section.css('p').each do |paragraph|
          if paragraph.text.downcase.include? 'expect notes of'
            coffee['tasting_notes'] = paragraph.css('strong').text.gsub(' | ', ', ') .titleize
          end
          coffee['tasting_notes'] = 'Try it and find out!' if coffee['tasting_notes'] == ''
        end

        coffee['country'] = /(?<=country: |location: )(.*?)(?=<)/i.match(coffee_description_section.to_s)
        coffee['region'] = /(?<=region: )(.*?)(?=<)/i.match(coffee_description_section.to_s)
        coffee['producer'] = /(?<=grower: )(.*?)(?=<)/i.match(coffee_description_section.to_s)
        coffee['process'] = /(?<=Preparation:|Process:)(.*?)(?=<br|<\/p>|<span)/.match(coffee_description_section.to_s)&.to_s&.sub(' ', '')
        coffee['variety'] = /(?<=variety: )(.*?)(?=<)/i.match(coffee_description_section.to_s)
        coffee['altitude'] = /(?<=altitude:)(.*?)(?=<)/i.match(coffee_description_section.to_s).to_s&.sub(' ', '')&.sub(' ', '')&.gsub(/\s.+/, '')&.gsub(/-.+/, '')&.gsub(',', '')&.gsub('+', '').to_i

        coffee['available'] = true

        @coffees << coffee
      end

      @coffees
    end
  end
end