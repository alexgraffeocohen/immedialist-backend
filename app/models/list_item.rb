class ListItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  belongs_to :user
  belongs_to :item, polymorphic: true
  # TODO: if it contains a requested item, it should destroy it on destroy
  has_one :search, dependent: :destroy

  after_update :clear_search_related_associations_if_user_selected_item

  def to_item_type
    item.to_item_type
  end

  private

  def clear_search_related_associations_if_user_selected_item
    if requested_item_replaced_with_real_item?
      requested_item = RequestedItem.find(item_id_was)
      requested_item.destroy

      search.destroy
      self.search = nil
    end
  end

  def requested_item_replaced_with_real_item?
    item_id_changed? && item_type_was == "RequestedItem" && item_type != "RequestedItem"
  end
end
