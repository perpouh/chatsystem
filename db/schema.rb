# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_08_07_105327) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "chat_session_id", null: false
    t.string "message"
    t.text "screen_shot_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_session_id"], name: "index_chat_messages_on_chat_session_id"
  end

  create_table "chat_sessions", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.string "session_key"
    t.string "user_agent"
    t.string "page_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chat_sessions_on_chat_id"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "api_key"
    t.string "api_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_chats_on_product_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.string "document_url"
    t.string "summery"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_documents_on_product_id"
    t.index ["summery"], name: "index_documents_on_summery"
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "chat_session_id", null: false
    t.string "message"
    t.text "screen_shot_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "issue_status", default: 0
    t.datetime "archived_at"
    t.index ["chat_session_id"], name: "index_issues_on_chat_session_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chat_messages", "chat_sessions"
  add_foreign_key "chat_sessions", "chats"
  add_foreign_key "chats", "products"
  add_foreign_key "chats", "users"
  add_foreign_key "documents", "products"
  add_foreign_key "issues", "chat_sessions"
  add_foreign_key "products", "users"
end
