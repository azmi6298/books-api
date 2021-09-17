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

ActiveRecord::Schema.define(version: 2021_09_15_121730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.text "bio"
    t.string "name"
    t.json "countries"
    t.string "gender"
    t.json "wikipedia"
    t.integer "n_books"
    t.text "summary"
    t.datetime "born"
    t.json "books"
    t.datetime "died"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.integer "author_id"
    t.string "author_name"
    t.string "content_name"
    t.string "isbn"
    t.string "original_title"
    t.integer "year"
    t.json "images_urls"
    t.string "language_code"
    t.json "images"
    t.string "category"
    t.string "plot"
    t.json "genres"
    t.string "copyright"
    t.json "wikipedia"
    t.decimal "average_rating"
    t.integer "rating_count"
    t.json "goodreads"
    t.json "similar_books"
    t.text "description"
    t.string "loc_class"
    t.json "gutenberg"
    t.json "authors"
    t.integer "pages"
    t.string "language"
    t.string "isbn13"
    t.json "countries"
    t.datetime "release_date"
    t.string "cover"
    t.text "summary"
    t.boolean "content_cleaned"
    t.json "classes"
    t.boolean "content_available"
    t.integer "n_authors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_books_on_title"
  end

  add_foreign_key "books", "authors"
end
