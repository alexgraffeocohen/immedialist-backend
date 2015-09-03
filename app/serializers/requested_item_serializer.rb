class RequestedItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :requested_type, :media_type

  def media_type
    object.to_item_type.associated_class.name.downcase
  end
end
