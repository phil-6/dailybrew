require "rails_helper"

RSpec.describe RoastersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/roasters").to route_to("roasters#index")
    end

    it "routes to #new" do
      expect(get: "/roasters/new").to route_to("roasters#new")
    end

    it "routes to #show" do
      expect(get: "/roasters/1").to route_to("roasters#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/roasters/1/edit").to route_to("roasters#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/roasters").to route_to("roasters#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/roasters/1").to route_to("roasters#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/roasters/1").to route_to("roasters#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/roasters/1").to route_to("roasters#destroy", id: "1")
    end
  end
end
