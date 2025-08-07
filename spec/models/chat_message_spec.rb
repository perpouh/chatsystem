# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'associations' do
    it { should belong_to(:chat_session) }
  end

  describe 'validations' do
    it { should validate_presence_of(:message) }
    
    context 'messageの長さが1000文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        chat_message = build(:chat_message, message: 'a' * 1001)
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:message]).to include('is too long (maximum is 1000 characters)')
      end
    end

    context 'screen_shot_urlが不正なURL形式の場合' do
      it 'バリデーションエラーが発生すること' do
        chat_message = build(:chat_message, screen_shot_url: 'invalid-url')
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:screen_shot_url]).to include('は有効なURL形式である必要があります')
      end
    end

    context 'screen_shot_urlが空の場合' do
      it 'バリデーションが通ること' do
        chat_message = build(:chat_message, screen_shot_url: nil)
        expect(chat_message).to be_valid
      end
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:chat_message)).to be_valid
    end

    it 'has a valid factory with screenshot' do
      expect(build(:chat_message, :with_screenshot)).to be_valid
    end

    it 'has a valid factory with long message' do
      expect(build(:chat_message, :long_message)).to be_valid
    end

    it 'has a valid factory with empty screenshot' do
      expect(build(:chat_message, :empty_screenshot)).to be_valid
    end
  end
end
