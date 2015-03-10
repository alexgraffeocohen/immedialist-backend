class ListItemSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :item_type
  has_one :item, polymorphic: true
  has_one :search, serializer: SearchSerializer
end
