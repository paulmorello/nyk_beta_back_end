class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  # prepend_before_action :require_no_authentication, :only => [:create]
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, except: [:new, :create]
  # before_action :set_countries
  # before_action :set_thumb


  private

  def create
    build_resource
    resource = User.find_for_database_authentication(:email => params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      sign_in("user", resource)
      current_user = resource
      byebyg
      # TODO POST to http://localhost:5000/auth creates a new user -- explore why devise auto-sends a response
      # also how to go from auth to /outlets?
      # render :json => {:success => true, :auth_token => resource.authentication_token, :login=>resource.login, email:=>resource.email, :current_user=>current_user}
      # redirect_to outlets_path
    end
  end


  def authenticate_user!
  end
  # List of currently used countries
  def set_countries
    writer_arr = Writer.select("country_id").distinct.map{|c| c.country_id}
    outlet_arr = Outlet.select("country_id").distinct.map{|c| c.country_id}
    @current_countries = (outlet_arr + writer_arr).sort.uniq
  end

  def set_thumb
    @thumb = ""
  end

  def is_admin?
    # redirect_to '/outlets' unless current_user.admin == true
    redirect_to '/outlets'
  end
end
