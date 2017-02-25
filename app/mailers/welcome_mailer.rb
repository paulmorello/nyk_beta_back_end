class WelcomeMailer < ApplicationMailer
  default from: 'nowyouknowpr@gmail.com'

  def welcome_email(params)
    @name = params["name"]
    @email = params["email"]
    @company_name = params["company_name"]
    @company_description = params["company_description"]
    @account = params["account"]
    mail(to: 'nowyouknowpr@gmail.com', subject: "New User Trial Signup: #{@name}" )
  end

  def client_email(params)
    @name = params["name"]
    @client_email = params["email"]
    mail(to: @client_email, subject: 'Welcome to NYK')
  end

  def scheduling_email(params)
    puts params
    @date = params["date"]
    @notes = params["notes"]
    @phone_number = params["phone_number"]
    @time_range = params["time_range"]
    mail(to: 'nowyouknowpr@gmail.com', subject: "New User Basic Signup" )
  end

end
