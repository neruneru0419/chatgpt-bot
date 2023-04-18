require 'openai'
require 'discordrb'
require 'byebug'
require 'dotenv'

require_relative 'chatgpt'

Dotenv.load

bot = Discordrb::Bot.new(token: ENV['DISCORD_TOKEN'])
settings_text = File.open("setting.txt", "r").read
message_historys = []
bot.message do |event|
  if event.channel.name == ENV['NAME']
    user_message = event.message.content
    chatgpt_content = create_text(message_historys, user_message, settings_text)
    event.send_message(chatgpt_content)

    message_historys.push(user_message)
    message_historys.push(chatgpt_content)
    if message_historys.size >= 8
      message_historys.shift
      message_historys.shift
    end
  end
end

bot.run
