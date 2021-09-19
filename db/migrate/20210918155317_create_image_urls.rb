class CreateImageUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :image_urls do |t|
      t.references  :book, foreign_key: true
      t.string      :url
      t.timestamps
    end
  end
end
