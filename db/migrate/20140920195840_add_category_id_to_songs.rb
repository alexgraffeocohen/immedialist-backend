class AddCategoryIdToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :category_id, :integer
  end
end
