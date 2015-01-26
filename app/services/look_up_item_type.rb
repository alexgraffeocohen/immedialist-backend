class LookUpItemType
  include Immedialist::ItemTypeConversion

  def self.call(requested_type)
    new(requested_type).call
  end

  def initialize(requested_type)
    @requested_type = requested_type
  end

  def call
    ItemType(@requested_type)
  end
end
