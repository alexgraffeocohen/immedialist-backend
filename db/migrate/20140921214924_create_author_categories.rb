class CreateAuthorCategories < ActiveRecord::Migration
  def change
    create_table :author_categories do |t|
      t.integer :author_id
      t.integer :category_id

      t.timestamps
    end
  end
end
