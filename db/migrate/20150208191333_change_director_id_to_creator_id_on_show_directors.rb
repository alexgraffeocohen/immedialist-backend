class ChangeDirectorIdToCreatorIdOnShowDirectors < ActiveRecord::Migration
  def change
    rename_column :show_directors, :director_id, :creator_id
  end
end
