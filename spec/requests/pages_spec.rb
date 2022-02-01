require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /main" do
    it "returns http success" do
      get "/pages/main"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/pages/about"
      expect(response).to have_http_status(:success)
    end
  end

end
