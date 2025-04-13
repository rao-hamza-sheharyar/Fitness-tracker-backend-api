class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    @url  = "http://localhost:3001/verify-email?token=#{user.confirmation_token}"
    mail(to: @user.email, subject: "Confirm your Fitness Tracker account")
  end
end
