class RemoveFilmetricColumnFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :filmetric, :integer
  end
end
