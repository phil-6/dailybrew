module FetchCoffees
  class OriginCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      roaster_url_root = 'https://www.origincoffee.co.uk'
      coffee_index_url = '/collections/coffee'
      coffee_css_on_index = '.grid-max .grid__item a.grid__image'
      exclude_types = %w[trio martini cold-brew pages]

      coffee_index_html = Net::HTTP.get_response(URI.parse(roaster_url_root + coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).uniq.each do |coffee_section|
        coffee = {}
        coffee['url'] = roaster_url_root + coffee_section[:href]
        next if exclude_types.any? { |s| coffee['url'].include? s }

        puts coffee['url']
        coffee['country'] = coffee_section.css('.product-copy p.product--vendor').text
        coffee['name'] = coffee_section.css('.product-copy p.h3').text
        coffee['tasting_notes'] = coffee_section.css('.product-copy p').text

        coffee_html = Net::HTTP.get_response(URI.parse(coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee_page.css('.product-description ul li').each do |detail|
          if detail.text.downcase.include? 'producer'
            next if detail.text.downcase.include? 'price'
            coffee['producer'] = detail.text.gsub(/.*:( |  | )/, '')
          elsif detail.text.downcase.include? 'region:'
            coffee['region'] = detail.text.gsub(/.*:( |  | )/, '')
          elsif detail.text.downcase.include? 'method:'
            coffee['process'] = detail.text.gsub(/.*:( |  | )/, '')
          elsif detail.text.downcase.include? 'varietal:'
            coffee['variety'] = detail.text.gsub(/.*:( |  | )/, '')
          elsif detail.text.downcase.include? 'elevation:'
            coffee['altitude'] = detail.text.gsub(/.*:( | )/, '').gsub(/-.*/, '').gsub(/ .*/, '').delete(',|m')
          end
        end

        coffee['description'] = coffee_page.css('main.wrapper.main-content div div.grid.grid-max.product-single div.grid__item.large--two-thirds.push--large--one-sixth.set-pad-top-30 div.product-description.rte div.page div.layoutArea div.column div.page div.layoutArea div.column').text

        coffee['available'] = true

        @coffees << coffee
      end
      @coffees
    end
  end
end