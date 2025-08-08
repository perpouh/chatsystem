# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    association :user
    sequence(:name) { |n| "Product #{n}" }
    description { "This is a test product description" }
  end
end
