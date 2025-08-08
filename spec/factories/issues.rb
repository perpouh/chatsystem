FactoryBot.define do
  factory :issue do
    # チャットセッションとの関連付け
    chat_session

    # デフォルトのメッセージ
    message { "テスト用の不具合報告メッセージ" }

    # デフォルトのスクリーンショットURL
    screen_shot_url { "https://example.com/screenshot.png" }

    # デフォルトは未対応ステータス
    issue_status { :pending }

    # アーカイブ日時はデフォルトでnil
    archived_at { nil }

    # 対応済みのIssueを作成するトレイト
    trait :resolved do
      issue_status { :resolved }
    end

    # 確認済みのIssueを作成するトレイト
    trait :confirmed do
      issue_status { :confirmed }
    end

    # アーカイブ済みのIssueを作成するトレイト
    trait :archived do
      issue_status { :resolved }
      archived_at { Time.current }
    end

    # 長いメッセージのIssueを作成するトレイト
    trait :long_message do
      message { "a" * 1000 }
    end

    # 無効なURLのIssueを作成するトレイト
    trait :invalid_url do
      screen_shot_url { "invalid-url-format" }
    end
  end
end
