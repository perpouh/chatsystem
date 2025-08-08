# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'associations' do
    it { should belong_to(:chat_session) }
  end

  describe 'validations' do
    context 'messageの長さが1000文字を超える場合' do
      it 'バリデーションエラーが発生すること' do
        issue = build(:issue, message: 'a' * 1001)
        expect(issue).not_to be_valid
        expect(issue.errors[:message]).to include('is too long (maximum is 1000 characters)')
      end
    end

    context 'screen_shot_urlが不正なURL形式の場合' do
      it 'バリデーションエラーが発生すること' do
        invalid_urls = [
          "invalid-url-format",
          "not-a-url",
          "ftp://invalid",
          "http://",
          "https://",
          "file:///path/to/file",
          "mailto:test@example.com"
        ]

        invalid_urls.each do |invalid_url|
          issue = build(:issue, screen_shot_url: invalid_url)
          expect(issue).not_to be_valid
          expect(issue.errors[:screen_shot_url]).to include('は有効なURL形式である必要があります')
        end
      end
    end

    context 'screen_shot_urlが正しいURL形式の場合' do
      it 'バリデーションが通ること' do
        valid_urls = [
          "https://example.com/screenshot.png",
          "http://example.com/image.jpg",
          "https://subdomain.example.com/path/to/image.gif",
          "https://example.com/path?param=value#fragment",
          "http://localhost:3000/image.png"
        ]

        valid_urls.each do |valid_url|
          issue = build(:issue, screen_shot_url: valid_url)
          expect(issue).to be_valid
        end
      end
    end

    context 'screen_shot_urlが空の場合' do
      it 'バリデーションが通ること' do
        issue = build(:issue, screen_shot_url: nil)
        expect(issue).to be_valid
      end
    end
  end

  describe 'enums' do
    it 'issue_statusのenumが正しく定義されていること' do
      expect(Issue.issue_statuses).to eq({
        "pending" => 0,    # 未対応
        "confirmed" => 1,  # 確認済み
        "resolved" => 2    # 対応済み
      })
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:issue)).to be_valid
    end
  end

  describe 'scopes' do
    let!(:pending_issue) { create(:issue, issue_status: :pending) }
    let!(:confirmed_issue) { create(:issue, issue_status: :confirmed) }
    let!(:resolved_issue) { create(:issue, issue_status: :resolved) }

    describe '.pending' do
      it 'pendingステータスのissueを返すこと' do
        expect(Issue.pending).to include(pending_issue)
        expect(Issue.pending).not_to include(confirmed_issue, resolved_issue)
      end
    end

    describe '.confirmed' do
      it 'confirmedステータスのissueを返すこと' do
        expect(Issue.confirmed).to include(confirmed_issue)
        expect(Issue.confirmed).not_to include(pending_issue, resolved_issue)
      end
    end

    describe '.resolved' do
      it 'resolvedステータスのissueを返すこと' do
        expect(Issue.resolved).to include(resolved_issue)
        expect(Issue.resolved).not_to include(pending_issue, confirmed_issue)
      end
    end
  end

  describe 'instance methods' do
    let(:issue) { create(:issue) }

    describe '#archive!' do
      it 'archived_atを設定すること' do
        expect { issue.archive! }.to change { issue.archived_at }.from(nil)
      end
    end

    describe '#archived?' do
      context 'archived_atが設定されている場合' do
        before { issue.archive! }

        it 'trueを返すこと' do
          expect(issue.archived?).to be true
        end
      end

      context 'archived_atが設定されていない場合' do
        it 'falseを返すこと' do
          expect(issue.archived?).to be false
        end
      end
    end
  end
end
