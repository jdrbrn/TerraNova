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

ActiveRecord::Schema.define(version: 2020_05_04_034233) do

  create_table "dncs", force: :cascade do |t|
    t.integer "terrid"
    t.string "number"
    t.string "street"
    t.string "name"
    t.string "publisher"
    t.date "date"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terrins", force: :cascade do |t|
    t.integer "terrid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terrouts", force: :cascade do |t|
    t.integer "terrid"
    t.string "publisher"
    t.date "dateout"
    t.date "datedue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terrs", force: :cascade do |t|
    t.string "name"
    t.string "region"
    t.date "datecomp"
    t.string "notes"
    t.text "history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
