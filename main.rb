require "openai"

api_key = "api-key"
client = OpenAI::Client.new(access_token: api_key)

response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: "Hello!" }],
    })
puts response.dig("choices", 0, "message", "content")