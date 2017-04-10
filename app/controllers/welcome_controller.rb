class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
<<<<<<< HEAD

  def index
    if params["account"] == 'Trial'
      # WelcomeMailer.welcome_email(params).deliver
      # WelcomeMailer.client_email(params).deliver
      WelcomeMailer.scheduling_email(params).deliver
    elsif params["account"] == 'Basic'
      WelcomeMailer.scheduling_email(params).deliver
    elsif params["account"] == 'mailingList'
      WelcomeMailer.mailing_list(params).deliver
    end
    render json: {status: 'Signup Successfully Sent'}
  end

=======
  def index
    if user_signed_in?
      redirect_to outlets_path
    end

  end
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
end
