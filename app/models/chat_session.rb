# frozen_string_literal: true

# Schema Information
#
# Table name: chat_sessions
#
#  id         :bigint           not null, primary key
#  chat_id    :bigint           not null
#  session_key :string           not null
#  user_agent  :string           not null
#  page_url    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chat_sessions_on_chat_id  (chat_id)
class ChatSession < ApplicationRecord
  belongs_to :chat
  has_many :chat_messages, dependent: :destroy
  has_one :issue, dependent: :destroy

  validates :user_agent, presence: true
  validates :page_url, presence: true

  before_create :generate_session_key

  def generate_session_key
    self.session_key = SecureRandom.hex(16)
  end
end
