# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatSession, type: :model do
  describe 'associations' do
    it { should belong_to(:chat) }
    it { should have_many(:chat_messages).dependent(:destroy) }
    it { should have_one(:issue).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_agent) }
    it { should validate_presence_of(:page_url) }
  end

  describe 'callbacks' do
    it 'セッションキーが作成されること' do
      chat_session = ChatSession.create(
        chat: create(:chat),
        user_agent: "test",
        page_url: "https://example.com"
      )
      expect(chat_session.session_key).not_to be_nil
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:chat_session)).to be_valid
    end
  end
end
