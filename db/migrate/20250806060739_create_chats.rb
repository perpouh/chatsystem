class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.string :api_key
      t.string :api_secret

      t.timestamps
    end
  end
end
