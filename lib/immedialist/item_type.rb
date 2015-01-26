module Immedialist
  SUPPORTED_ITEM_TYPES = [:movie, :show, :actor, :director, :book, :author,
                          :song, :album, :artist]

  class ItemType
    def name
      self.class.name.split('::').last
    end

    SUPPORTED_ITEM_TYPES.each do |type|
      class_name = type.to_s.capitalize
      self.const_set(class_name, Class.new(self))
    end
  end
end
