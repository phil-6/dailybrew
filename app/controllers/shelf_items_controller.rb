class ShelfItemsController < ApplicationController
  def index
    @shelf_coffees = current_user.shelf_coffees
  end

  def create
    @shelf_item = ShelfItem.create(user: current_user, coffee_id: params[:coffee_id])
    @coffee = @shelf_item.coffee

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @shelf_item = ShelfItem.find_by(user: current_user, coffee_id: params[:coffee_id])
    @coffee = @shelf_item.coffee
    @shelf_item.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end
end
