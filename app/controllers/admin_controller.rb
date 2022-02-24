# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :stats, only: :dashboard

  # GET /admin/dashboard/
  def dashboard
    @pagy, @users = pagy(User.all.order('created_at DESC'), items: 10)

    render 'dashboard'
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
