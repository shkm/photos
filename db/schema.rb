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

ActiveRecord::Schema.define(version: 20170817180358) do

  create_table "albums", force: :cascade do |t|
    t.string  "name"
    t.date    "date"
    t.integer "cover_photo_id"
    t.index ["cover_photo_id"], name: "index_albums_on_cover_photo_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "external_id", null: false
    t.string   "link"
    t.string   "filename"
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.datetime "datetime"
    t.integer  "width"
    t.integer  "height"
    t.integer  "size"
    t.integer  "album_id"
    t.index ["album_id"], name: "index_photos_on_album_id"
  end

end
