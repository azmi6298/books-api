class ClassBook < ActiveRecord::Base
  has_many :book_classes
  has_many :books, through: :book_classes, source: :class_book
end
