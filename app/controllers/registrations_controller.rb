# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def update_subscription_interest
    current_user.update!(subscription_interest_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'subscription_interest_toggle',
          partial: 'pages/subscription_interest_toggle'
        )
      end
    end
  end

  def update_profile_privacy
    current_user.update!(profile_privacy_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'profile_privacy_toggle',
          partial: 'users/profile_privacy_toggle'
        )
      end
    end
  end

  protected

  def subscription_interest_params
    params.require(:user).permit(:subscription_interest)
  end

  def profile_privacy_params
    params.require(:user).permit(:public_profile)
  end
end
