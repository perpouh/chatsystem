FactoryBot.define do
  factory :chat_session do
    chat
    user_agent { Faker::Internet.user_agent }
    page_url { Faker::Internet.url }
  end
end
