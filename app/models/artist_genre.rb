class ArtistGenre < ActiveRecord::Base
  belongs_to :genre
  belongs_to :creator
end
