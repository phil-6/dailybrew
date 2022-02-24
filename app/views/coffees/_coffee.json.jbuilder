json.extract! coffee, :id, :roaster_id, :name, :country, :region, :town, :lat, :lng, :process, :altitude, :variety,
              :tasting_notes, :producer, :description, :url, :created_at, :updated_at
json.url coffee_url(coffee, format: :json)
