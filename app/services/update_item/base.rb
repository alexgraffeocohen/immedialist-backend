class UpdateItem::Base
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

  def update_association!(api_resource, api_identifier, model_name, join_model_name, association_name)
    api_resource.send(association_name).each do |association_resource|
      resource_in_db = model_name.find_by(
        api_identifier => association_resource.send(api_identifier)
      )

      if resource_in_db
        item.send(join_model_name).find_or_create_by!(
          model_name.table_name.singularize => resource_in_db
        )
      else
        item.send(association_name) << model_name.
          create!(association_resource.attributes)
      end
    end
  end
end
