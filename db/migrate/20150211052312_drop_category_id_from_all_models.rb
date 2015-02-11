class DropCategoryIdFromAllModels < ActiveRecord::Migration
  def change
    remove_column :books, :category_id
    remove_column :movies, :category_id
    remove_column :shows, :category_id
    remove_column :songs, :category_id
    remove_column :albums, :category_id
  end
end
