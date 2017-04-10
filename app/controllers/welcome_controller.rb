class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

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

end
