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

  protected

  def subscription_interest_params
    params.require(:user).permit(:subscription_interest)
  end

end
