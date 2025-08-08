class CreateChatSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :chat_sessions do |t|
      t.references :chat, null: false, foreign_key: true
      t.string :session_key
      t.string :user_agent
      t.string :page_url

      t.timestamps
    end
  end
end
