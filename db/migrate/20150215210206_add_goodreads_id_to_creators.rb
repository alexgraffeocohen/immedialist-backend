class AddGoodreadsIdToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :goodreads_id, :integer
  end
end
