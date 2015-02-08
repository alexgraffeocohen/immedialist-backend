class ChangePeopleToCreators < ActiveRecord::Migration
  def change
    rename_table :people, :creators
  end
end
