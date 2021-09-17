class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string    :title
      t.integer   :author_id
      t.string    :author_name
      t.string    :content_name
      t.string    :isbn
      t.string    :original_title
      t.integer   :year
      t.json      :images_urls
      t.string    :language_code
      t.json      :images
      t.string    :category
      t.string    :plot
      t.json      :genres
      t.string    :copyright
      t.json      :wikipedia
      t.decimal   :average_rating
      t.integer   :rating_count
      t.json      :goodreads
      t.json      :similar_books
      t.text      :description
      t.string    :loc_class
      t.json      :gutenberg
      t.json      :authors
      t.integer   :pages
      t.string    :language
      t.string    :isbn13
      t.json      :countries
      t.datetime  :release_date
      t.string    :cover
      t.text      :summary
      t.boolean   :content_cleaned
      t.json      :classes
      t.boolean   :content_available
      t.integer   :n_authors

      t.timestamps
    end

    add_foreign_key :books, :authors
    add_index :books, :title
  end
end
