class WelcomeController < ApplicationController
  # skip_before_action :authenticate_user!
  def index
    if user_signed_in?
      redirect_to outlets_path
    end

  end
end
