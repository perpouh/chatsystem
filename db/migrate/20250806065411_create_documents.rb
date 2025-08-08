class CreateDocuments < ActiveRecord::Migration[7.2]
  def change
    create_table :documents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.string :title
      t.string :document_url
      t.string :summery, index: true

      t.timestamps
    end
  end
end
