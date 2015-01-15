class Query < ActiveRecord::Base
  belongs_to :list_item

  after_create :inherit_list_item_name

  validates_presence_of :list_item

  private

  def inherit_list_item_name
    self.name = list_item.name
  end
end
