class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :item, polymorphic: true

  after_save :change_name_to_item_name

  private

  def change_name_to_item_name
    if item
      self.name = item.name
    end
  end
end
