# frozen_string_literal: true

# Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  product_id :bigint           not null
#  api_key    :string           not null
#  api_secret :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chats_on_product_id  (product_id)
#  index_chats_on_user_id      (user_id)
#
class Chat < ApplicationRecord
  before_create :generate_api_key_and_secret
  belongs_to :user
  belongs_to :product
  has_many :chat_sessions, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }

  def generate_api_key_and_secret
    self.api_key = SecureRandom.hex(16)
    self.api_secret = SecureRandom.hex(16)
  end
end
