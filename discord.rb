require 'discordrb'
require "openai"
require "byebug"

def chatgpt_response(content)
  api_key = "token"
  client = OpenAI::Client.new(access_token: api_key)

  response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: content }],
      })
  response.dig("choices", 0, "message", "content")
end

bot = Discordrb::Commands::CommandBot.new token: 'token',
                                          client_id: "713713249060651138" ,
                                          prefix: '/'
# 何かメッセージが送信されたら実行
bot.message do |event|
  byebug
  p event.message.to_s
end

bot.run