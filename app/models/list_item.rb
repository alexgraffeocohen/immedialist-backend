class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :item, polymorphic: true
  belongs_to :category

  after_save :change_name_to_item_name

  validates_presence_of :category

  private

  def change_name_to_item_name
    if item
      self.name = item.name
    end
  end
end
