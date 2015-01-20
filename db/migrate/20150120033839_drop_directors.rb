class DropDirectors < ActiveRecord::Migration
  def change
    drop_table :directors
  end
end
