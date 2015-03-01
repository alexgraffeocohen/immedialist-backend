class Search < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  belongs_to :list_item

  after_save :inherit_list_item_name

  validates_presence_of :list_item

  private

  def inherit_list_item_name
    self.name = list_item.name
  end
end
