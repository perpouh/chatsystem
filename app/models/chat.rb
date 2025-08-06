class Chat < ApplicationRecord
  belongs_to :user
  has_one :document
end
