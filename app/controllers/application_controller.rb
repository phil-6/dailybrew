# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :turbo_frame_request_variant

  protected

  def sign_out_notice
    notice = session[:sign_out_notice]
    return unless notice.present?

    flash.now[:alert] = notice
    session.delete(:sign_out_notice)
  end

  def authorize_admin
    return if current_user.admin

    redirect_back(fallback_location: root_path, flash: { error: "You don't have permission to do that action." })
  end

  def configure_permitted_parameters
    attributes = %i[email username first_name last_name password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: attributes
    devise_parameter_sanitizer.permit :account_update, keys: attributes
  end

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
