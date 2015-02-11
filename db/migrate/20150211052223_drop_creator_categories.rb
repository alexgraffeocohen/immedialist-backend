class DropCreatorCategories < ActiveRecord::Migration
  def change
    drop_table :creator_categories
  end
end
