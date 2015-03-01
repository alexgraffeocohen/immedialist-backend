class ListItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic: true
  has_one :search

  after_save :inherit_item_name

  private

  def inherit_item_name
    self.name = item.name
  end
end
