class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :item, polymorphic: true
  belongs_to :category

  after_save :change_name_to_item_if_item_present

  validates_presence_of :category
  validate :attached_to_correct_item_class

  private

  def change_name_to_item_if_item_present
    if item
      self.name = item.name
    end
  end

  def attached_to_correct_item_class
    return if item.nil?
    if item.category != category
      errors.add(:item, 'category must match list_item category')
    end
  end
end
