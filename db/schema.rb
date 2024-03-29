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

ActiveRecord::Schema[7.0].define(version: 2022_12_10_014459) do
  create_table "cards", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "pin", null: false
    t.date "expiration", null: false
    t.string "owner", null: false
    t.string "bank", null: false
    t.integer "kind", default: 0, null: false
    t.integer "user_id", null: false
    t.integer "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
    t.index ["wallet_id"], name: "index_cards_on_wallet_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "plate", null: false
    t.string "insurance", null: false
    t.string "brand", null: false
    t.string "model", null: false
    t.integer "kilometers", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "car_number"
    t.string "color"
    t.string "photo"
    t.boolean "remove", default: false
    t.float "latitude"
    t.float "longitude"
    t.float "position"
    t.integer "state", default: 0
    t.float "fuel", default: 0.0
    t.string "location"
    t.boolean "blocked", default: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "feed_backs", force: :cascade do |t|
    t.text "comment", default: ""
    t.integer "score", null: false
    t.integer "user_id", null: false
    t.integer "car_id", null: false
    t.integer "rental_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_feed_backs_on_car_id"
    t.index ["rental_id"], name: "index_feed_backs_on_rental_id"
    t.index ["user_id"], name: "index_feed_backs_on_user_id"
  end

  create_table "fines", force: :cascade do |t|
    t.integer "price"
    t.string "motive"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rental_id"
    t.integer "state", default: 0
    t.integer "user_id"
  end

  create_table "licenses", force: :cascade do |t|
    t.date "expire"
    t.string "photo"
    t.integer "state", default: 0
    t.string "motive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "car_id", null: false
    t.float "price", default: 22.5
    t.float "hours", default: 1.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state"
    t.datetime "taken_at"
    t.datetime "finished_at"
    t.integer "fine_id"
    t.index ["car_id"], name: "index_rentals_on_car_id"
    t.index ["fine_id"], name: "index_rentals_on_fine_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users"
    t.integer "fines"
    t.integer "rentals"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "dni", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "role", default: 0
    t.integer "wallet_id"
    t.integer "license_id"
    t.boolean "blocked", default: false
    t.datetime "birthday", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "state", default: 0
    t.integer "fine_id"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["fine_id"], name: "index_users_on_fine_id"
    t.index ["license_id"], name: "index_users_on_license_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["wallet_id"], name: "index_users_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.float "money", default: 0.0
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "cards", "users"
  add_foreign_key "cards", "wallets"
  add_foreign_key "feed_backs", "cars"
  add_foreign_key "feed_backs", "rentals"
  add_foreign_key "feed_backs", "users"
  add_foreign_key "rentals", "cars"
  add_foreign_key "rentals", "fines"
  add_foreign_key "rentals", "users"
  add_foreign_key "users", "fines"
  add_foreign_key "users", "licenses"
  add_foreign_key "users", "wallets"
  add_foreign_key "wallets", "users"
end
