class ChangeAuthorIdToCreatorIdOnBookAuthors < ActiveRecord::Migration
  def change
    rename_column :book_authors, :author_id, :creator_id
  end
end
