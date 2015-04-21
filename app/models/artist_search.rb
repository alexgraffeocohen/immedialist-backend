class ArtistSearch < ActiveRecord::Base
  belongs_to :creator
  belongs_to :search, class_name: Search::Artist
end
