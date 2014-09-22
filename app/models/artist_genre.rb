class ArtistGenre < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist, class_name: Person, foreign_key: :artist_id
end
