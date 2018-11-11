class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(candidates, message)
    client = Busibe::Client.new({public_key: ENV['PUBLIC_KEY'], access_token: ENV['ACCESS_TOKEN']})
    candidates.each do |s|
      payload = {
        to: s.phone_number,
        from: "DAGOMO",
        message: message
      }
      client.send_sms payload
    end
  end
end
