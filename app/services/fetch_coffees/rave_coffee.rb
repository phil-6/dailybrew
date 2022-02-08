module FetchCoffees
  class RaveCoffee
    require 'open-uri'
    require 'net/http'
    require 'json'
    require 'nokogiri'

    def scrape
      @coffees = []
      coffee_index_url = 'https://ravecoffee.co.uk/collections/single-origin-coffee'
      coffee_css_on_index = '.grid-item .cl-product-card-name a'
      exclude_types = %w[sacks bags]

      coffee_index_html = Net::HTTP.get_response(URI.parse(coffee_index_url))
      coffee_index_page = Nokogiri::HTML(coffee_index_html.body)

      coffee_index_page.css(coffee_css_on_index).uniq.each do |coffee_section|
        coffee = {}
        coffee['url'] = 'https://ravecoffee.co.uk' + coffee_section[:href]
        next if exclude_types.any? { |s| coffee['url'].include? s }

        puts coffee['url']
        coffee_html = Net::HTTP.get_response(URI.parse(coffee['url']))
        coffee_page = Nokogiri::HTML(coffee_html.body)

        coffee['country'] = coffee_page.css('head title').text.gsub(/\s.+/, '')

        # I hate this, but Rave doesn't make it easy to get country of origin
        if coffee['country'] == 'Timor'
          coffee['country'] = 'Timor Leste'
        elsif coffee['country'] == 'Costa'
          coffee['country'] = 'Costa Rica'
        end

        coffee['name'] = coffee_page.css('span.breadcrumbs-title-pdp').text
        coffee['tasting_notes'] = coffee_page.css('.product-details-taste .body-bold').text
        coffee['region'] = coffee_page.css('.origin-table h3').text

        coffee_page.css('.origin-table-data .table-item').each do |detail|
          if detail.css('.table-item-text').text.downcase.include? 'altitude'
            coffee['altitude'] = detail.css('p.body-bold').text.gsub(/m.*/, '')
          elsif detail.css('.table-item-text').text.downcase.include? 'producer'
            coffee['producer'] = detail.css('p.body-bold').text
          elsif detail.css('.table-item-text').text.downcase.include? 'process'
            coffee['process'] = detail.css('p.body-bold').text
          elsif detail.css('.table-item-text').text.downcase.include? 'varietal'
            coffee['variety'] = detail.css('p.body-bold').text
          elsif detail.css('.table-item-text').text.downcase.include? 'grown'
            coffee['town'] = detail.css('p.body-bold').text
          end
        end

        coffee['description'] =
          coffee_page.css('.slideout-body-pdp-description').text + coffee_page.css('.origin-table .table-main-content').text

        @coffees << coffee
      end

      @coffees
    end
  end
end
