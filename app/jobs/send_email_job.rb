class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(candidates, message)
    candidates.each do |s|
      begin
        UserMailer.with(submission: s, message: message).success_email.deliver
        s.update(email_sent: "YES")
      rescue => e
        logger.error(e)
      end
    end
  end
end
