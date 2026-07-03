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

ActiveRecord::Schema[8.1].define(version: 2026_07_03_095658) do
  create_table "athletes", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.string "line_user_id"
    t.string "name", null: false
    t.text "notes"
    t.string "phone"
    t.date "started_on", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "athlete_id", null: false
    t.datetime "cancelled_at"
    t.datetime "created_at", null: false
    t.date "end_date", null: false
    t.integer "package_plan_id", null: false
    t.decimal "price_paid", precision: 10, scale: 2, null: false
    t.date "start_date", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_memberships_on_athlete_id"
    t.index ["end_date"], name: "index_memberships_on_end_date"
    t.index ["package_plan_id"], name: "index_memberships_on_package_plan_id"
  end

  create_table "package_plans", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.boolean "bike", default: false, null: false
    t.integer "billing_cycle", null: false
    t.datetime "created_at", null: false
    t.integer "duration_days", null: false
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.boolean "run", default: false, null: false
    t.boolean "swim", default: false, null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.date "due_on", null: false
    t.integer "membership_id", null: false
    t.date "paid_on"
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_payments_on_membership_id"
  end

  create_table "race_entries", force: :cascade do |t|
    t.integer "athlete_id", null: false
    t.datetime "created_at", null: false
    t.string "discipline"
    t.date "race_date", null: false
    t.string "race_name", null: false
    t.string "result"
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_race_entries_on_athlete_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "channel", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "membership_id", null: false
    t.text "message_body", null: false
    t.datetime "sent_at"
    t.integer "status", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_reminders_on_membership_id"
  end

  add_foreign_key "memberships", "athletes"
  add_foreign_key "memberships", "package_plans"
  add_foreign_key "payments", "memberships"
  add_foreign_key "race_entries", "athletes"
  add_foreign_key "reminders", "memberships"
end
