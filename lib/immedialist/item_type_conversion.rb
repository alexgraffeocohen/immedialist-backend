module Immedialist
  module ItemTypeConversion
    def to_item_type
      type_name = self.class.name.split('::').last
      ItemType(type_name)
    end

    module_function

    def ItemType(item_type)
      item_type = String(item_type).capitalize

      case item_type
      when ItemType then item_type
      else ItemType.const_get(item_type).new
      end

    rescue
      raise ArgumentError, "Could not convert #{item_type.inspect} to ItemType"
    end
  end
end
