class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_countries

  private
  
  # List of currently used countries
  def set_countries
    writer_arr = Writer.select("country_id").distinct.map{|c| c.country_id}
    outlet_arr = Outlet.select("country_id").distinct.map{|c| c.country_id}
    @current_countries = (outlet_arr + writer_arr).sort.uniq
  end
end
