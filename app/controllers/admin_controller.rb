# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :users

  # GET /admin/dashboard/
  def dashboard
    render 'dashboard'
  end

  private

  def users
    @users = User.all
  end
end
