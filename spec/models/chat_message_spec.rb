# チャットメッセージモデルのテスト
require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  # アソシエーションのテスト
  describe 'associations' do
    it 'belongs to chat_session' do
      expect(ChatMessage.reflect_on_association(:chat_session).macro).to eq :belongs_to
    end
  end

  # バリデーションのテスト
  describe 'validations' do
    let(:chat_session) { create(:chat_session) }

    # 有効なチャットメッセージ
    context 'with valid attributes' do
      it 'is valid with valid attributes' do
        chat_message = build(:chat_message, chat_session: chat_session)
        expect(chat_message).to be_valid
      end

      it 'is valid with screenshot URL' do
        chat_message = build(:chat_message, :with_screenshot, chat_session: chat_session)
        expect(chat_message).to be_valid
      end

      it 'is valid with empty screenshot URL' do
        chat_message = build(:chat_message, :empty_screenshot, chat_session: chat_session)
        expect(chat_message).to be_valid
      end

      it 'is valid with maximum length message' do
        chat_message = build(:chat_message, :long_message, chat_session: chat_session)
        expect(chat_message).to be_valid
      end
    end

    # チャットセッションが存在しない場合のテスト
    context 'when chat_session does not exist' do
      it 'is not valid without chat_session' do
        chat_message = build(:chat_message, chat_session: nil)
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:chat_session]).to include("must exist")
      end
    end

    # メッセージが空の場合のテスト
    context 'when message is empty' do
      it 'is not valid without message' do
        chat_message = build(:chat_message, message: nil, chat_session: chat_session)
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:message]).to include("can't be blank")
      end

      it 'is not valid with empty string message' do
        chat_message = build(:chat_message, message: '', chat_session: chat_session)
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:message]).to include("can't be blank")
      end
    end

    # メッセージが1000文字を超えた場合のテスト
    context 'when message exceeds 1000 characters' do
      it 'is not valid with message longer than 1000 characters' do
        chat_message = build(:chat_message, message: 'a' * 1001, chat_session: chat_session)
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:message]).to include("is too long (maximum is 1000 characters)")
      end
    end

    # スクリーンショットURLが不正なURL形式の場合のテスト
    context 'when screenshot URL is invalid' do
      it 'is not valid with invalid URL format' do
        chat_message = build(:chat_message, screen_shot_url: 'invalid-url', chat_session: chat_session)
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:screen_shot_url]).to include("は有効なURL形式である必要があります")
      end

      it 'is not valid with malformed URL' do
        chat_message = build(:chat_message, screen_shot_url: 'http://', chat_session: chat_session)
        expect(chat_message).not_to be_valid
        expect(chat_message.errors[:screen_shot_url]).to include("は有効なURL形式である必要があります")
      end
    end

    # スクリーンショットURLが空でも保存できるテスト
    context 'when screenshot URL is empty' do
      it 'is valid with nil screenshot URL' do
        chat_message = build(:chat_message, screen_shot_url: nil, chat_session: chat_session)
        expect(chat_message).to be_valid
      end

      it 'is valid with empty string screenshot URL' do
        chat_message = build(:chat_message, screen_shot_url: '', chat_session: chat_session)
        expect(chat_message).to be_valid
      end
    end
  end

  # ファクトリーのテスト
  describe 'factories' do
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
