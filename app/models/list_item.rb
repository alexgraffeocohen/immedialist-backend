class ListItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic: true
  has_one :search

  after_save :change_name_to_item_if_item_present

  private

  def change_name_to_item_if_item_present
    if item
      self.name = item.name
    end
  end
end
