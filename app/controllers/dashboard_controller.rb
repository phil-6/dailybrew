class DashboardController < ApplicationController
  def index
    @inventories = current_user.inventories.includes(:coffee).last(5)
    @favourites = current_user.favourites.includes(:coffee).last(5)
    @brews = current_user.brews.includes(:coffee).last(10)
  end
end
