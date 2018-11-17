class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(candidates, message)
    client = Busibe::Client.new({public_key: ENV['PUBLIC_KEY'], access_token: ENV['ACCESS_TOKEN']})
    candidates.each do |s|
      begin
        payload = {
          to: s.phone_number,
          from: "DAGOMO",
          message: message
        }
        client.send_sms payload

        s.update(sms_sent: "YES")
      rescue => e
        logger.error(e)
      end
    end
  end
end
