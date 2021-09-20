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

ActiveRecord::Schema.define(version: 2021_09_19_074424) do

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
    t.datetime "died"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "book_authors", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "book_classes", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "class_book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_classes_on_book_id"
    t.index ["class_book_id"], name: "index_book_classes_on_class_book_id"
  end

  create_table "book_contents", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "author_id"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_book_contents_on_author_id"
    t.index ["book_id"], name: "index_book_contents_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
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
    t.integer "pages"
    t.string "language"
    t.string "isbn13"
    t.json "countries"
    t.datetime "release_date"
    t.string "cover"
    t.text "summary"
    t.boolean "content_cleaned"
    t.text "book_classes"
    t.boolean "content_available"
    t.integer "n_authors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "class_books", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_urls", force: :cascade do |t|
    t.bigint "book_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_image_urls_on_book_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "book_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_images_on_book_id"
  end

  add_foreign_key "book_authors", "authors"
  add_foreign_key "book_authors", "books"
  add_foreign_key "book_classes", "books"
  add_foreign_key "book_classes", "class_books"
  add_foreign_key "book_contents", "authors"
  add_foreign_key "book_contents", "books"
  add_foreign_key "image_urls", "books"
  add_foreign_key "images", "books"
end
