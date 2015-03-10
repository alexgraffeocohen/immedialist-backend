class SearchSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name
  has_many :results, polymorphic: true, key: :item_ids, root: :items
end
