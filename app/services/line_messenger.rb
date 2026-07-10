class LineMessenger
  ENDPOINT = URI("https://api.line.me/v2/bot/message/push")

  def self.push(line_user_id:, text:)
    new.push(line_user_id: line_user_id, text: text)
  end

  def push(line_user_id:, text:)
    token = Rails.application.credentials.dig(:line, :channel_access_token)
    return false if token.blank? || line_user_id.blank?

    http = Net::HTTP.new(ENDPOINT.host, ENDPOINT.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(ENDPOINT, {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{token}"
    })
    request.body = { to: line_user_id, messages: [ { type: "text", text: text } ] }.to_json

    response = http.request(request)
    response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    Rails.logger.error("LineMessenger push failed: #{e.message}")
    false
  end
end
