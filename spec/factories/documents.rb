FactoryBot.define do
  factory :document do
    title { "test" }
    document_url { "https://example.com" }
    summery { "test" }
    association :product
  end
end
