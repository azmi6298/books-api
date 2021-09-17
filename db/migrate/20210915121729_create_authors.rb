class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.text      :bio
      t.string    :name
      t.json      :countries
      t.string    :gender
      t.json      :wikipedia
      t.integer   :n_books
      t.text      :summary
      t.datetime  :born
      t.json      :books
      t.datetime  :died

      t.timestamps
    end

    add_index :authors, :name
  end
end
