class DropActors < ActiveRecord::Migration
  def change
    drop_table :actors
  end
end
