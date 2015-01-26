module Immedialist
  class ItemType
    SUPPORTED_TYPES = [:movie, :show, :actor, :director, :book, :author,
                       :song, :album, :artist]

    def name
      self.class.name.split('::').last
    end

    SUPPORTED_TYPES.each do |type|
      class_name = type.to_s.capitalize
      Immedialist::ItemType.const_set(class_name, Class.new(ItemType))
    end
  end
end
