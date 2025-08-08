FactoryBot.define do
  factory :chat do
    title { "test" }
    user
    association :product
  end
end
