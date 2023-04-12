def create_text(message_historys, content, settings_text)
  api_key = ENV['CHATGPT_API_KEY']
  client = OpenAI::Client.new(access_token: api_key)

  if message_historys.empty?
    content_array = [
      {role: "system", content: settings_text},
      {role: "user", content: content},
    ]
  else
    content_array = [{role: "system", content: settings_text}] + get_message_history(message_historys) + [{role: "user", content: content}]
  end
  p content_array
  response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: content_array,
      })
  response.dig("choices", 0, "message", "content")
end

def create_image_from_text(text)
  api_key = ENV['CHATGPT_API_KEY']
  client = OpenAI::Client.new(access_token: api_key)

  response = client.images.generate(parameters: { prompt: text, size: "256x256" })
  response.dig("data", 0, "url")
end

def get_message_history(message_historys)
  messages = []
  message_historys.each_slice(2).to_a.each do |message|
    messages.push({role: "user", content: message[0]})
    messages.push({role: "assistant", content: message[1]})
  end
  messages
end