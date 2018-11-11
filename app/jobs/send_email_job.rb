class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(candidates, message)
    candidates.each do |s|
      UserMailer.with(submission: s, message: message).success_email.deliver
    end
  end
end
