class CreateDirectorCategories < ActiveRecord::Migration
  def change
    create_table :director_categories do |t|
      t.integer :director_id
      t.integer :category_id

      t.timestamps
    end
  end
end
