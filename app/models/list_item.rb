class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :item, polymorphic: true
  belongs_to :category
  has_one :search

  after_save :change_name_to_item_if_item_present

  validates_presence_of :category

  private

  def change_name_to_item_if_item_present
    if item
      self.name = item.name
    end
  end
end
