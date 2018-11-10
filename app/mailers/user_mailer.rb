class UserMailer < ApplicationMailer
  def success_email
    @submission = params[:submission]
    @message = params[:message]
    mail(to: @submission.email, subject: "Dagomo Article")
  end
end
