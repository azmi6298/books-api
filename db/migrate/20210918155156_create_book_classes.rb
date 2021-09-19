class CreateBookClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :book_classes do |t|
      t.references  :book, foreign_key: true
      t.references  :class_book, foreign_key: true
      t.timestamps
    end
  end
end
