# frozen_string_literal: true

# Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
class Product < ApplicationRecord
  belongs_to :user
  has_many :documents, dependent: :destroy
  has_one :chat, dependent: :destroy

  validates :name, presence: true, length: { maximum: 200 }
  validates :description, length: { maximum: 1000 }
end
