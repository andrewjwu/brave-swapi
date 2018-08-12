# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_12_171510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "people", force: :cascade do |t|
    t.integer "swapi_id"
    t.string "name"
    t.string "birth_year"
    t.string "eye_color", default: "n/a"
    t.string "gender", default: "n/a"
    t.string "hair_color", default: "n/a"
    t.string "height"
    t.string "mass"
    t.string "skin_color"
    t.string "homeworld"
    t.string "films", default: [], array: true
    t.string "species", default: [], array: true
    t.string "starships", default: [], array: true
    t.string "vehicles", default: [], array: true
    t.string "url"
    t.string "created"
    t.string "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["swapi_id"], name: "index_people_on_swapi_id", unique: true
  end

  create_table "planets", force: :cascade do |t|
    t.integer "swapi_id"
    t.string "name"
    t.string "rotation_period"
    t.string "orbital_period"
    t.string "diameter"
    t.string "climate"
    t.string "gravity"
    t.string "terrain"
    t.string "surface_water"
    t.string "population"
    t.string "residents", default: [], array: true
    t.string "films", default: [], array: true
    t.string "created"
    t.string "edited"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["swapi_id"], name: "index_planets_on_swapi_id", unique: true
  end

end
