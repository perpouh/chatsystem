# frozen_string_literal: true

# Schema Information
#
# Table name: issues
#
#  id              :bigint           not null, primary key
#  chat_session_id :bigint           not null
#  message         :string
#  screen_shot_url :text
#  issue_status    :integer          default(0)
#  archived_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_issues_on_chat_session_id  (chat_session_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_session_id => chat_sessions.id)
class Issue < ApplicationRecord
  # チャットセッションとの関連付け
  belongs_to :chat_session

  # ステータスのenum定義
  # 未対応: 0, 確認済み: 1, 対応済み: 2
  enum issue_status: {
    pending: 0,    # 未対応
    confirmed: 1,  # 確認済み
    resolved: 2    # 対応済み
  }

  # バリデーション
  # チャットセッションが存在していることを確認
  validates :chat_session, presence: true

  # メッセージは1000文字を超えないことを確認
  validates :message, length: { maximum: 1000 }, allow_blank: true

  # スクリーンショットURLがhttpまたはhttpsのURL形式であることを確認
  validates :screen_shot_url, format: {
    with: /\Ahttps?:\/\/.+\z/,
    message: "は有効なURL形式である必要があります"
  }, allow_blank: true

  # アーカイブ処理を行うメソッド
  # 対応済みステータスに変更し、アーカイブ日時を設定する
  def archive!
    update!(issue_status: :resolved, archived_at: Time.current)
  end

  # アーカイブされているかどうかを判定するメソッド
  def archived?
    archived_at.present?
  end

  # 対応可能なステータスかどうかを判定するメソッド
  def actionable?
    !resolved? && !archived?
  end
end
