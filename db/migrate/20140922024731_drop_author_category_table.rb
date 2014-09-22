class DropAuthorCategoryTable < ActiveRecord::Migration
  def change
    drop_table :author_categories
  end
end
