module Immedialist
  module ItemTypeConversion
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
