class AddColumnDocumentToChat < ActiveRecord::Migration[7.2]
  def change
    add_reference :chats, :document, foreign_key: true
  end
end
