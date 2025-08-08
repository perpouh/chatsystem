# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:document_url) }
    it { should validate_presence_of(:summery) }
    
    context 'titleの長さが200文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        document = build(:document, title: 'a' * 201)
        expect(document).not_to be_valid
        expect(document.errors[:title]).to include('is too long (maximum is 200 characters)')
      end
    end

    context 'document_urlが不正なURL形式の場合' do
      it 'バリデーションエラーが発生すること' do
        document = build(:document, document_url: 'invalid-url')
        expect(document).not_to be_valid
        expect(document.errors[:document_url]).to include('is invalid')
      end
    end

    context 'summeryの長さが1000文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        document = build(:document, summery: 'a' * 1001)
        expect(document).not_to be_valid
        expect(document.errors[:summery]).to include('is too long (maximum is 1000 characters)')
      end
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:document)).to be_valid
    end
  end
end 