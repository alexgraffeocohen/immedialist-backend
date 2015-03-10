class SongSearch < ActiveRecord::Base
  belongs_to :song
  belongs_to :search, class_name: Search::Song
end
