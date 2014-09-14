class AddTrailerLinkToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :trailer_link, :string
  end
end
