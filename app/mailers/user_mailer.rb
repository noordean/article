class UserMailer < ApplicationMailer
  def success_email
    @submission = params[:submission]
    mail(to: @submission.email, subject: "Congrats!")
  end
end
