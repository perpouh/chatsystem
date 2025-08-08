class RemoveColumnChatFromDocuments < ActiveRecord::Migration[7.2]
  def change
    remove_reference :documents, :chat, foreign_key: true
  end
end
