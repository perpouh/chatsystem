# frozen_string_literal: true

# Schema Information
#
# Table name: chat_messages
#
#  id         :bigint           not null, primary key
#  chat_session_id :bigint           not null
#  message      :string           not null  
#  screen_shot_url :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
class ChatMessage < ApplicationRecord
  # チャットセッションとの関連付け
  belongs_to :chat_session

  # バリデーション
  # チャットセッションの存在確認
  validates :chat_session, presence: true
  
  # メッセージの必須チェックと文字数制限（1000文字以下）
  validates :message, presence: true, length: { maximum: 1000 }
  
  # スクリーンショットURLのURL形式バリデーション（空の場合は許可）
  validates :screen_shot_url, format: {
    with: /\Ahttps?:\/\/.+\z/,
    message: "は有効なURL形式である必要があります"
  }, allow_blank: true
end
