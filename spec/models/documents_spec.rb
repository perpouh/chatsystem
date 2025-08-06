require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:user) { create(:user) }
  describe 'Documentレコードの作成' do
    context 'Documentレコードの作成' do
      it 'Documentレコードが作成できること' do
        document = Document.new(title: 'test', document_url: 'https://example.com', summery: 'test', user: user)
        expect(document).to be_valid
      end
    end

    context '引数無しでDocumentレコードを作成する場合' do
      it 'バリデーションエラーが発生すること' do
        document = Document.new
        expect(document).not_to be_valid
        expect(document.errors.full_messages).to include("Title can't be blank")
        expect(document.errors.full_messages).to include("Document url can't be blank")
        expect(document.errors.full_messages).to include("Summery can't be blank")
        expect(document.errors.full_messages).to include("User must exist")
      end
    end

    context 'titleが200文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        document = Document.new(title: 'a' * 201, document_url: 'https://example.com', summery: 'test', user: user)
        expect(document).not_to be_valid
        expect(document.errors.full_messages).to include("Title is too long (maximum is 200 characters)")
      end
    end

    context 'document_urlがURL形式でない場合' do
      it 'バリデーションエラーが発生すること' do
        document = Document.new(title: 'test', document_url: 'test', summery: 'test', user: user)
        expect(document).not_to be_valid
        expect(document.errors.full_messages).to include("Document url is invalid")
      end
    end
  end
end 