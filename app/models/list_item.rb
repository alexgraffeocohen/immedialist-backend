class ListItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  belongs_to :user
  belongs_to :item, polymorphic: true
  # TODO: if it contains a requested item, it should destroy it on destroy
  has_one :search, dependent: :destroy

  after_update :delete_search_if_user_selected_item

  def to_item_type
    item.to_item_type
  end

  private

  def delete_search_if_user_selected_item
    if item_id_changed? && !item.kind_of?(RequestedItem)
      search.destroy
      self.search = nil
    end
  end
end
