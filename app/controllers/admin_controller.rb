# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :stats, only: :index

  # GET /admin/
  def index
    @pagy_users, @users = pagy(User.all.order('created_at DESC'), items: 20, page_param: :page_users)
    @pagy_roasters, @roasters = pagy(Roaster.all.order('last_coffee_fetch ASC'), items: 20, page_param: :page_roasters)
    @pagy_coffees, @coffees = pagy(Coffee.all.order('updated_at DESC').includes(:roaster), items: 20, page_param: :page_coffees)
    render 'dashboard'
  end

  def update_all_coffees
    flash.now[:alert] = 'Updating All Coffees'
    Roaster.with_coffees.each(&:update_coffees)
  end

  def icon_sl
    render 'icon-sl'
  end

  def icon_basic
    render 'icon-basic'
  end

  private

  def stats
    @stats = {}
    @stats['user_count'] = User.count
    @stats['roaster_count'] = Roaster.count
    @stats['roaster_with_coffees'] = Roaster.with_coffees.count
    @stats['coffee_count'] = Coffee.count
    @stats['coffee_with_brews'] = Coffee.joins(:brews).distinct.count
    @stats['brews_count'] = Brew.count
    @stats['daily_brews'] = Brew.today.count
    @stats['user_with_brews'] = User.joins(:brews).distinct.count
  end
end
