class ListItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  belongs_to :user
  belongs_to :item, polymorphic: true
  # TODO: if it contains a requested item, it should destroy it on destroy
  has_one :search, dependent: :destroy

  def to_item_type
    item.to_item_type
  end
end
