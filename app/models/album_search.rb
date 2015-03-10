class AlbumSearch < ActiveRecord::Base
  belongs_to :album
  belongs_to :search, class_name: Search::Album
end
