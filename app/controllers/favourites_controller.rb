class FavouritesController < ApplicationController
  def index
    @favourites = current_user.favourite_coffees
  end

  def create
    @favourite = Favourite.create(user: current_user, coffee_id: params[:coffee_id])
    @coffee = @favourite.coffee

    respond_to do |format|
      format.turbo_stream { render 'toggle' }
    end
  end

  def destroy
    @favourite = Favourite.find_by(user: current_user, coffee_id: params[:coffee_id])
    @coffee = @favourite.coffee
    @favourite.destroy

    respond_to do |format|
      format.turbo_stream { render 'toggle' }
    end
  end
end
