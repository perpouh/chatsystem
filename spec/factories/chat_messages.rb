# チャットメッセージのファクトリー
FactoryBot.define do
  factory :chat_message do
    # 基本的なチャットメッセージ
    association :chat_session
    message { "これはテストメッセージです。" }

    # スクリーンショットURL付きのファクトリー
    trait :with_screenshot do
      screen_shot_url { "https://example.com/screenshot.png" }
    end

    # 長いメッセージのファクトリー（テスト用）
    trait :long_message do
      message { "a" * 1000 }
    end

    # 空のスクリーンショットURLのファクトリー
    trait :empty_screenshot do
      screen_shot_url { nil }
    end
  end
end
