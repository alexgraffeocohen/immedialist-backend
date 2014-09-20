class Song < ActiveRecord::Base
  has_many   :song_artists
  has_many   :artists, through: :song_artists
  belongs_to :album
  belongs_to :category

  before_save :define_category

  private

  def define_category
    self.category = Category.find_or_create_by(name: "Music")
  end
end
