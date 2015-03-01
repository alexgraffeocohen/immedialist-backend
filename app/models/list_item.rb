class ListItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  belongs_to :user
  belongs_to :item, polymorphic: true
  has_one :search

  after_save :inherit_item_name

  def to_item_type
    ItemType(item_type)
  end

  private

  def inherit_item_name
    self.name = item.name
  end
end
