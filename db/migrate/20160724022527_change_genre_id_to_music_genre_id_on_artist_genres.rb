class ChangeGenreIdToMusicGenreIdOnArtistGenres < ActiveRecord::Migration
  def change
    rename_column :artist_genres, :genre_id, :music_genre_id
  end
end
