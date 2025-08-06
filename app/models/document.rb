# frozen_string_literal: true

# Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  document_url :string           not null
#  summery      :string           not null
class Document < ApplicationRecord
  belongs_to :user
  has_one :chat
  
  validates :title, presence: true, length: { maximum: 200 }
  validates :document_url, presence: true, format: { with: URI::regexp, message: 'is invalid' }
  validates :summery, presence: true, length: { maximum: 1000 }
end
