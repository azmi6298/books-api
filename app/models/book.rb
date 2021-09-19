class Book < ActiveRecord::Base
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_classes
  has_many :classes, through: :book_classes, source: :class_book
  has_many :book_contents
  has_many :images
  has_many :image_urls
  # has_many :similar_books
end
