class DashboardController < ApplicationController
  def index
    @shelf_coffees = current_user.shelf_coffees.last(5)
    @favourites = current_user.favourite_coffees.last(5)
    @brews = current_user.brews.order('created_at DESC').includes(:coffee).first(10)
  end
end
