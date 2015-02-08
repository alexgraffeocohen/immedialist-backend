class ArtistAlbum < ActiveRecord::Base
  belongs_to :creator
  belongs_to :album
end
