require 'rails_helper'

RSpec.describe ChatSession, type: :model do
  let(:chat) { create(:chat) }

  describe 'ChatSessionレコードの作成' do
    context 'ChatSessionレコードの作成' do
      it '引数無しでChatSessionレコードを作成する場合' do
        chat_session = ChatSession.new
        expect(chat_session).not_to be_valid
        expect(chat_session.errors.full_messages).to include("User agent can't be blank")
        expect(chat_session.errors.full_messages).to include("Page url can't be blank")
      end
    end

    context 'セッションキーの作成' do
      it 'セッションキーが作成されること' do
        chat_session = ChatSession.create(chat: chat, user_agent: "test", page_url: "https://example.com")
        expect(chat_session.session_key).not_to be_nil
      end
    end
  end
end
