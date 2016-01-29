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

  def update_genres!(api_resource, api_identifier)
    join_model_name = "#{item.class.name.downcase}_genres"

    api_resource.genres.each do |association_record|
      db_record = Genre.find_by(
        api_identifier => association_record.send(api_identifier)
      )

      if db_record
        item.send(join_model_name).find_or_create_by!(genre: db_record)
      else
        item.genres << Genre.create!(association_record.attributes)
      end
    end
  end

  def update_actors!(api_resource, api_identifier)
    update_creator_association!(api_resource, api_identifier, "actors")
  end

  def update_directors!(api_resource, api_identifier)
    update_creator_association!(api_resource, api_identifier, "directors")
  end

  def update_creator_association!(api_resource, api_identifier, association_name)
    join_model_name = "#{item.class.name.downcase}_#{association_name}"

    api_resource.send(association_name).each do |association_record|
      db_record = Creator.find_by(
        api_identifier => association_record.send(api_identifier)
      )

      if db_record
        item.send(join_model_name).find_or_create_by!(creator: db_record)
      else
        item.send(association_name) << Creator.create!(association_record.attributes)
      end
    end
  end
end
