class WelcomeMailer < ApplicationMailer
  default from: 'nowyouknowpr@gmail.com'

  def welcome_email(params)
    @name = params["name"]
    @email = params["email"]
    @company_name = params["company_name"]
    @company_description = params["company_description"]
    @account = params["account"]
    mail(to: 'stefanhartmann@gmail.com', subject: "New User Signup: #{@name}" )
  end

  def client_email(params)
    @name = params["name"]
    @client_email = params["email"]
    mail(to: @client_email, subject: 'Welcome to NYK')
  end

end
