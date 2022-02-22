module FetchCoffees
  class AssemblyCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_url_root = 'https://assemblycoffee.co.uk/'
      coffee_index_url = 'collections/buy-coffee'
      coffee_css_on_index = '.product-card a'
      exclude_types = %w[package]

      coffee_index_html = Net::HTTP.get_response(URI.parse(roaster_url_root + coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).each do |coffee_section|
        coffee = {}
        coffee['url'] = coffee_section[:href]
        next if exclude_types.any? { |s| coffee['url'].include? s }

        puts coffee['url']
        coffee_html = Net::HTTP.get_response(URI.parse(roaster_url_root + coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee['name'] = coffee_page.css('h1.product-single__title').text

        coffee_details_list = coffee_page.css('.product-single__description ul')

        producer = /(?<=Producer|Farmer)(.*?)(?=<\/)/.match(coffee_details_list.to_s).to_s
        producer = producer.gsub(/.*<span data-mce-fragment="1">/, '').gsub(/<meta charset="utf-8">/, '').gsub(/ /, '').gsub(/—/, '').sub(/\s*/, '')
        coffee['producer'] = producer

        region = /(?<=Region)(.*?)(?=<\/)/.match(coffee_details_list.to_s).to_s
        region = region.gsub(/.*<span data-mce-fragment="1">/, '').gsub(/<meta charset="utf-8">/, '').gsub(/ /, '').gsub(/—/, '').sub(/\s*/, '')
        coffee['region'] = region

        process = /(?<=Process)(.*?)(?=<\/)/.match(coffee_details_list.to_s).to_s
        process = process.gsub(/.*<span data-mce-fragment="1">/, '').gsub(/<meta charset="utf-8">/, '').gsub(/ /, '').gsub(/—/, '').sub(/\s*/, '')
        coffee['process'] = process

        variety = /(?<=Varietal|Varietals)(.*?)(?=<\/)/.match(coffee_details_list.to_s).to_s
        variety = variety.gsub(/.*<span data-mce-fragment="1">/, '').gsub(/<meta charset="utf-8">/, '').gsub(/ /, '').gsub(/—/, '').sub('s','').sub(/\s*/, '')
        coffee['variety'] = variety

        altitude = /(?<=Altitude|Terroir)(.*?)(?=<\/)/.match(coffee_details_list.to_s).to_s
        altitude = altitude.gsub(/.*<span data-mce-fragment="1">/, '').gsub(/<meta charset="utf-8">/, '').gsub(/ /, '').gsub(/—/, '').sub(/\s*/, '')
        altitude = altitude.sub(/\smasl/, '').sub(/-.*/,'')
        coffee['altitude'] = altitude

        coffee['tasting_notes'] = coffee_page.at_css('.product-single__description h2:contains("Tastes like")')&.next_element&.text

        coffee['available'] = true

        @coffees << coffee
      end

      # puts @coffees.to_json
      @coffees
    end
  end
end