# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:documents).dependent(:destroy) }
    it { should have_one(:chat).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    
    context 'nameの長さが200文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        product = build(:product, name: 'a' * 201)
        expect(product).not_to be_valid
        expect(product.errors[:name]).to include('is too long (maximum is 200 characters)')
      end
    end

    context 'descriptionの長さが1000文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        product = build(:product, description: 'a' * 1001)
        expect(product).not_to be_valid
        expect(product.errors[:description]).to include('is too long (maximum is 1000 characters)')
      end
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:product)).to be_valid
    end
  end
end
