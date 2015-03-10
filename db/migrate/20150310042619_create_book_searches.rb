class CreateBookSearches < ActiveRecord::Migration
  def change
    create_table :book_searches do |t|
      t.integer :book_id
      t.integer :search_id

      t.timestamps null: false
    end
  end
end
