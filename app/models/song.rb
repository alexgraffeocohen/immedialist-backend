class Song < ActiveRecord::Base
  has_many   :artists, through: :album
  belongs_to :album
  has_many :list_items, as: :item
end
