module FetchCoffees
  class GirlsWhoGrind
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_url_root = 'https://girlswhogrindcoffee.com'
      coffee_index_url = '/collections/coffee'
      coffee_css_on_index = '.product--root a'
      exclude_types = %w[esperanza jar triptych sampler]

      coffee_index_html = Net::HTTP.get_response(URI.parse(roaster_url_root + coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).uniq.each do |coffee_section|
        coffee = {}
        coffee['url'] = roaster_url_root + coffee_section[:href]
        next if exclude_types.any? { |s| coffee['url'].include? s }

        puts coffee['url']
        coffee_html = Net::HTTP.get_response(URI.parse(coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee['name'] = coffee_page.css('.product-page--title').inner_html.gsub(/<svg (.|\n)*/, '').gsub(/\n */, '')
        coffee['tasting_notes'] = coffee_page.css('.product-page--description').css('h1, h2').first.text

        coffee_page.css('.product-page--description p').each do |detail|
          if detail.text.downcase.include? 'producer: '
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
          elsif detail.text.downcase.include? 'farm: '
            coffee['town'] = detail.text.gsub(/.*: /, '')
          end
        end

        coffee['available'] = true

        @coffees << coffee
      end

      @coffees
    end
  end
end
