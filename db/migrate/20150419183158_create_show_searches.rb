class CreateShowSearches < ActiveRecord::Migration
  def change
    create_table :show_searches do |t|
      t.integer :show_id
      t.integer :search_id

      t.timestamps null: false
    end
  end
end
