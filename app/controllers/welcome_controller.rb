class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:account] == 'basic'
      WelcomeMailer.scheduling_email(params).deliver
    else
      WelcomeMailer.welcome_email(params).deliver
      WelcomeMailer.client_email(params).deliver
    end
    render json: {status: 'Signup Successfully Sent'}
  end

end
