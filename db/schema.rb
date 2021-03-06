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

ActiveRecord::Schema.define(version: 2021_12_25_073222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_accounts_on_uid_and_provider", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bank_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id", null: false
    t.uuid "bank_id", null: false
    t.string "acct", null: false
    t.string "comment"
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acct"], name: "index_bank_accounts_on_acct", unique: true
    t.index ["bank_id"], name: "index_bank_accounts_on_bank_id"
    t.index ["partner_id"], name: "index_bank_accounts_on_partner_id"
  end

  create_table "banks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "title", null: false
    t.string "brief_title"
    t.string "legal_address"
    t.string "postal_address"
    t.string "phone"
    t.string "email", null: false
    t.string "url"
    t.string "corr_acc", null: false
    t.string "corr_acc_with", null: false
    t.string "bic", null: false
    t.string "inn", null: false
    t.string "kpp"
    t.string "ogrn"
    t.string "okpo"
    t.string "okato"
    t.string "comment"
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bic"], name: "index_banks_on_bic", unique: true
    t.index ["corr_acc"], name: "index_banks_on_corr_acc", unique: true
    t.index ["email"], name: "index_banks_on_email", unique: true
    t.index ["inn"], name: "index_banks_on_inn", unique: true
    t.index ["name"], name: "index_banks_on_name", unique: true
    t.index ["title"], name: "index_banks_on_title", unique: true
  end

  create_table "partner_banks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id", null: false
    t.uuid "bank_id", null: false
    t.string "account"
    t.string "comment"
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_id"], name: "index_partner_banks_on_bank_id"
    t.index ["partner_id"], name: "index_partner_banks_on_partner_id"
  end

  create_table "partners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "title", null: false
    t.integer "kind", limit: 2, default: 3, null: false
    t.integer "role", limit: 2, default: 0, null: false
    t.string "email", null: false
    t.string "url"
    t.string "inn", null: false
    t.string "kpp"
    t.string "ogrn"
    t.string "ogrnip"
    t.string "okpo"
    t.string "okato"
    t.string "certificate_number"
    t.date "certificate_date"
    t.integer "status", limit: 2, default: 0, null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_partners_on_code", unique: true
    t.index ["email"], name: "index_partners_on_email", unique: true
    t.index ["inn"], name: "index_partners_on_inn", unique: true
    t.index ["name"], name: "index_partners_on_name", unique: true
    t.index ["title"], name: "index_partners_on_title", unique: true
  end

  create_table "partners_banks", id: false, force: :cascade do |t|
    t.uuid "partner_id", null: false
    t.uuid "bank_id", null: false
    t.string "current_account", null: false
    t.text "comment"
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_id"], name: "index_partners_banks_on_bank_id"
    t.index ["current_account"], name: "index_partners_banks_on_current_account", unique: true
    t.index ["partner_id"], name: "index_partners_banks_on_partner_id"
  end

  create_table "phones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "number", null: false
    t.integer "kind", limit: 2, default: 0, null: false
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["number"], name: "index_phones_on_number", unique: true
  end

  create_table "samples", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "title", null: false
    t.decimal "price", default: "0.0", null: false
    t.integer "quantity", default: 0, null: false
    t.integer "position"
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_samples_on_name", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "role", limit: 2, default: 0, null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_accounts", "banks"
  add_foreign_key "bank_accounts", "partners"
  add_foreign_key "partner_banks", "banks"
  add_foreign_key "partner_banks", "partners"
  add_foreign_key "partners_banks", "banks"
  add_foreign_key "partners_banks", "partners"
end
