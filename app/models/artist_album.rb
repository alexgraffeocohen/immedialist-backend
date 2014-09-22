class ArtistAlbum < ActiveRecord::Base
  belongs_to :artist, class_name: Person, foreign_key: :artist_id
  belongs_to :album
end
