class DashboardController < ApplicationController
  def index
    @shelf_coffees = current_user.shelf_coffees
    @favourites = current_user.favourite_coffees
    @pagy, @brews = pagy(current_user.brews.order('created_at DESC').includes(:coffee), items: 10)
  end
end
