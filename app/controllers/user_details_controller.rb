class UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def user_deets
    render json: { sign_in_count: current_user.sign_in_count }
  end

end
