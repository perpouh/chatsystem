require 'rails_helper'

RSpec.describe Issue, type: :model do
  # テスト用のファクトリを定義
  let(:chat_session) { create(:chat_session) }
  let(:issue) { build(:issue, chat_session: chat_session) }

  describe 'バリデーション' do
    context 'チャットセッションが存在しない場合' do
      it '保存できないこと' do
        issue_without_session = build(:issue, chat_session: nil)
        expect(issue_without_session).not_to be_valid
        expect(issue_without_session.errors.full_messages).to include("Chat session must exist")
      end
    end

    context 'メッセージが空の場合' do
      it '保存できること' do
        issue_without_message = build(:issue, chat_session: chat_session, message: nil)
        expect(issue_without_message).to be_valid
      end
    end

    context 'メッセージが1000文字を超える場合' do
      it 'エラーとなること' do
        long_message = "a" * 1001
        issue_with_long_message = build(:issue, chat_session: chat_session, message: long_message)
        expect(issue_with_long_message).not_to be_valid
        expect(issue_with_long_message.errors.full_messages).to include("Message is too long (maximum is 1000 characters)")
      end
    end

    context 'メッセージが1000文字の場合' do
      it '保存できること' do
        exact_message = "a" * 1000
        issue_with_exact_message = build(:issue, chat_session: chat_session, message: exact_message)
        expect(issue_with_exact_message).to be_valid
      end
    end

    context 'スクリーンショットURLが空の場合' do
      it '保存できること' do
        issue_without_url = build(:issue, chat_session: chat_session, screen_shot_url: nil)
        expect(issue_without_url).to be_valid
      end
    end

    context 'スクリーンショットURLが正しいURL形式でない場合' do
      it 'エラーとなること' do
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
          issue_with_invalid_url = build(:issue, chat_session: chat_session, screen_shot_url: invalid_url)
          expect(issue_with_invalid_url).not_to be_valid
          expect(issue_with_invalid_url.errors.full_messages).to include("Screen shot url は有効なURL形式である必要があります")
        end
      end
    end

    context 'スクリーンショットURLが正しいURL形式の場合' do
      it '保存できること' do
        valid_urls = [
          "https://example.com/screenshot.png",
          "http://example.com/image.jpg",
          "https://subdomain.example.com/path/to/image.gif",
          "https://example.com/path?param=value#fragment",
          "http://localhost:3000/image.png"
        ]

        valid_urls.each do |valid_url|
          issue_with_valid_url = build(:issue, chat_session: chat_session, screen_shot_url: valid_url)
          expect(issue_with_valid_url).to be_valid
        end
      end
    end

    context 'すべてのバリデーションが通る場合' do
      it 'Issueが作成できること' do
        expect(issue).to be_valid
      end
    end
  end

  describe 'enum' do
    context 'issue_statusのenum' do
      it '正しいステータスが定義されていること' do
        expect(Issue.issue_statuses).to eq({
          "pending" => 0,    # 未対応
          "confirmed" => 1,  # 確認済み
          "resolved" => 2    # 対応済み
        })
      end

      it 'デフォルトが未対応であること' do
        new_issue = create(:issue, chat_session: chat_session)
        expect(new_issue.pending?).to be true
      end
    end
  end

  describe '関連付け' do
    it 'chat_sessionと関連付けられていること' do
      expect(issue.chat_session).to eq(chat_session)
    end
  end

  describe '#archive!' do
    let(:issue_to_archive) { create(:issue, chat_session: chat_session) }

    it 'ステータスを対応済みに変更し、アーカイブ日時を設定すること' do
      expect {
        issue_to_archive.archive!
      }.to change { issue_to_archive.reload.issue_status }.from("pending").to("resolved")
        .and change { issue_to_archive.reload.archived_at }.from(nil)

      expect(issue_to_archive.resolved?).to be true
      expect(issue_to_archive.archived_at).to be_present
    end
  end

  describe '#archived?' do
    context 'アーカイブ日時が設定されている場合' do
      it 'trueを返すこと' do
        archived_issue = create(:issue, :archived, chat_session: chat_session)
        expect(archived_issue.archived?).to be true
      end
    end

    context 'アーカイブ日時が設定されていない場合' do
      it 'falseを返すこと' do
        expect(issue.archived?).to be false
      end
    end
  end

  describe '#actionable?' do
    context '未対応でアーカイブされていない場合' do
      it 'trueを返すこと' do
        expect(issue.actionable?).to be true
      end
    end

    context '確認済みでアーカイブされていない場合' do
      it 'trueを返すこと' do
        confirmed_issue = create(:issue, :confirmed, chat_session: chat_session)
        expect(confirmed_issue.actionable?).to be true
      end
    end

    context '対応済みの場合' do
      it 'falseを返すこと' do
        resolved_issue = create(:issue, :resolved, chat_session: chat_session)
        expect(resolved_issue.actionable?).to be false
      end
    end

    context 'アーカイブされている場合' do
      it 'falseを返すこと' do
        archived_issue = create(:issue, :archived, chat_session: chat_session)
        expect(archived_issue.actionable?).to be false
      end
    end
  end
end
