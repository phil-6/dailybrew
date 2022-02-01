json.extract! roaster, :id, :user_id, :name, :description, :location, :lat, :lng, :website, :twitter, :instagram, :facebook, :created_at, :updated_at
json.url roaster_url(roaster, format: :json)
