class ChangeDocumentIdToProductIdInChats < ActiveRecord::Migration[7.2]
  def change
    remove_reference :chats, :document, foreign_key: true
    add_reference :chats, :product, null: false, foreign_key: true
  end
end
