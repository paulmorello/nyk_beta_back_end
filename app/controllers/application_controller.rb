class ApplicationController < ActionController::Base
<<<<<<< HEAD
  protect_from_forgery with: :null_session

  include DeviseTokenAuth::Concerns::SetUserByToken

  # prepend_before_action :require_no_authentication, :only => [:create]
  before_action :authenticate_user!, except: [:new, :create, :edit]
  # before_action :sign_in_count, except: [:new, :create]
  # before_action :configure_permitted_parameters, if: :devise_controller?

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
      # TODO POST to http://localhost:5000/auth creates a new user -- explore why devise auto-sends a response
      # also how to go from auth to /outlets?
      # render :json => {:success => true, :auth_token => resource.authentication_token, :login=>resource.login, email:=>resource.email, :current_user=>current_user}
      # redirect_to outlets_path
    end
  end


=======
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_countries
  before_action :set_thumb

  private

>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
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
<<<<<<< HEAD
    # redirect_to '/outlets' unless current_user.admin == true
    redirect_to '/outlets'
=======
    redirect_to '/outlets' unless current_user.admin == true
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  end
end
