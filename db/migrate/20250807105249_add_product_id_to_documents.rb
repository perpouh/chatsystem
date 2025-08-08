class AddProductIdToDocuments < ActiveRecord::Migration[7.2]
  def change
    remove_reference :documents, :user, foreign_key: true
    add_reference :documents, :product, null: false, foreign_key: true
  end
end
