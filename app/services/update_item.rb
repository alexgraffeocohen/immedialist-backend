class UpdateItem
  def self.call(item)
    new(item).call
  end

  def initialize(item)
    @item = item
  end

  def call
    update_item!
  end

  private

  attr_reader :item

  def update_item!
    raise NotImplementedError
  end
end
