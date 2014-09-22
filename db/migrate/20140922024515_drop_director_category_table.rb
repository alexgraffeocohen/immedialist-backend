class DropDirectorCategoryTable < ActiveRecord::Migration
  def change
    drop_table :director_categories
  end
end
