class WelcomeController < ApplicationController
  # skip_before_action :authenticate_user!
  def index
    if params[:account] == 'basic'
      # send out the basic email
    else
      WelcomeMailer.welcome_email(params).deliver
      WelcomeMailer.client_email(params).deliver
    end
    render json: {status: 'Signup Successfully Sent'}
  end
end
