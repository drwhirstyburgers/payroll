# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_17_213628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.integer "employee_id"
    t.float "sum_of_hours", default: 0.0
    t.float "sum_of_wages", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "job_groups", force: :cascade do |t|
    t.string "name"
    t.float "wage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payroll_reports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "report_id"
  end

  create_table "rows", force: :cascade do |t|
    t.bigint "payroll_report_id", null: false
    t.string "pay_period"
    t.float "amount_paid"
    t.integer "employee_id"
    t.string "job_group"
    t.float "total_hours_worked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payroll_report_id"], name: "index_rows_on_payroll_report_id"
  end

  add_foreign_key "rows", "payroll_reports"
end
