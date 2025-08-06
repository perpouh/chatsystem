require 'rails_helper'

RSpec.describe Chat, type: :model do
  let(:user) { create(:user) }
  let(:document) { create(:document) }

  describe 'Chatレコードの作成' do

    context '引数無しでChatレコードを作成する場合' do
      it 'バリデーションエラーが発生すること' do
        chat = Chat.new
        expect(chat).not_to be_valid
        expect(chat.errors.full_messages).to include("User must exist")
        expect(chat.errors.full_messages).to include("Document must exist")
        expect(chat.errors.full_messages).to include("Title can't be blank")
      end
    end

    context 'titleが200文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        chat = Chat.new(title: 'a' * 201)
        expect(chat).not_to be_valid
        expect(chat.errors.full_messages).to include("Title is too long (maximum is 200 characters)")
      end
    end

    context 'バリデーションエラーが無い場合' do
      it 'Chatレコードが作成できること' do
        chat = Chat.new(user: user, document: document, title: "test")
        expect(chat).to be_valid
      end
      it 'APIキーとAPIシークレットが作成されること' do
        chat = Chat.create(user: user, document: document, title: "test")
        expect(chat.api_key).not_to be_nil
        expect(chat.api_secret).not_to be_nil
      end
    end

  end
end 