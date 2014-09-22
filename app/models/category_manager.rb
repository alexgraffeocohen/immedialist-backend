class CategoryManager
  attr_accessor :model

  ASSOCIATION_CATEGORY_MAP = {
    movies_directed: "Film",
    movies_acted_in: "Film",
    shows_directed:  "Television",
    shows_acted_in:  "Television",
    books:  "Book",
    songs:  "Music",
    albums: "Music",
  }
  POSSIBLE_ASSOCIATIONS = ASSOCIATION_CATEGORY_MAP.keys

  def initialize(model)
    self.model = model
  end

  def assign_categories
    POSSIBLE_ASSOCIATIONS.each do |association|
      if model_has(association) && model_does_not_already_have_category_for(association)
        assign_category_for(association)
      end
    end
  end

  private

  def assign_category_for(association)
    model.categories << Category.find_or_create_by(name: ASSOCIATION_CATEGORY_MAP[association])
  end

  def model_has(association)
    model.try(association) && !model.send(association).empty?
  end

  def model_does_not_already_have_category_for(association)
    !model.categories.map(&:name).include?(ASSOCIATION_CATEGORY_MAP[association])
  end
end
