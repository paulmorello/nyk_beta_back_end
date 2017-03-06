class WelcomeMailer < ApplicationMailer
  default from: 'nowyouknowpr@gmail.com'

  def welcome_email(params)
    @name = params["name"]
    @email = params["email"]
    @company_name = params["company_name"]
    @company_description = params["company_description"]
    @account = params["account"]
    mail(to: 'stefanhartmann@gmail.com', subject: "New User Trial Signup: #{@name}" )
  end

  def client_email(params)
    @name = params["name"]
    @client_email = params["email"]
    mail(to: @client_email, subject: 'Welcome to NYK')
  end

  def scheduling_email(params)
    @name = params["name"]
    @email = params["email"]
    @email = params["email"]
    @company_name = params["company_name"]
    @company_description = params["company_description"]
    @account = params["account"]
    @date = params["date"]
    if params["notes"] == nil
      @notes = params["notes"]
    else
      @notes = "Nothing to add."
    end
    @phone_number = params["phone_number"]
    @time_range = params["time_range"]
    mail(to: 'stefanhartmann@gmail.com', subject: "New User Basic Signup: #{@name}" )
  end

  def mailing_list(params)
    @email = params["email"]
    @name = params["name"]
    mail(to: 'stefanhartmann@gmail.com', subject: "New Mailing List Signup: #{@name}")
  end

end
