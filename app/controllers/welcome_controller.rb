class WelcomeController < ApplicationController
  # skip_before_action :authenticate_user!
  def index
    WelcomeMailer.welcome_email(params).deliver
  end
end
