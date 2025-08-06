class CreateIssues < ActiveRecord::Migration[7.2]
  def change
    create_table :issues do |t|
      t.references :chat_session, null: false, foreign_key: true
      t.string :message
      t.text :screen_shot_url

      t.timestamps
    end
  end
end
