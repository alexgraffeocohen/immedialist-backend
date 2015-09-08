class SearchSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name
  has_one :list_item
end
