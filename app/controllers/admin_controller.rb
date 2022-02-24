# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :users

  # GET /admin/dashboard/
  def dashboard
    @pagy, @users = pagy(@users.order('created_at DESC'), items: 10)
    render 'dashboard'
  end

  private

  def users
    @users = User.first(10)
  end
end
