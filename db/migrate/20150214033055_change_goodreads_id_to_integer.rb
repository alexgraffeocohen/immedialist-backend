class ChangeGoodreadsIdToInteger < ActiveRecord::Migration
  def up
    change_column :books, :goodreads_id, :integer
  end

  def down
    change_column :books, :goodreads_id, :string
  end
end
