class CreateBookContents < ActiveRecord::Migration[5.2]
  def change
    create_table :book_contents do |t|
      t.references  :book, foreign_key: true
      t.references  :author, foreign_key: true
      t.text        :title
      t.timestamps
    end
  end
end
