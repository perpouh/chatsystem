# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
    it { should have_many(:chat_sessions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    
    context 'titleの長さが200文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        chat = build(:chat, title: 'a' * 201)
        expect(chat).not_to be_valid
        expect(chat.errors[:title]).to include('is too long (maximum is 200 characters)')
      end
    end
  end

  describe 'callbacks' do
    it 'APIキーとAPIシークレットが作成されること' do
      chat = Chat.create(user: create(:user), product: create(:product), title: "test")
      expect(chat.api_key).not_to be_nil
      expect(chat.api_secret).not_to be_nil
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:chat)).to be_valid
    end
  end
end 