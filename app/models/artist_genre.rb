class ArtistGenre < ActiveRecord::Base
  belongs_to :music_genre
  belongs_to :creator
end
