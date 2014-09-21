class CategoryManager
  attr_accessor :model

  ASSOCIATION_CATEGORY_MAP = {
    movies: "Film",
    shows:  "Television",
    books:  "Book",
    songs:  "Music",
  }
  POSSIBLE_ASSOCIATIONS = ASSOCIATION_CATEGORY_MAP.keys

  def initialize(model)
    self.model = model
  end

  def assign_categories
    POSSIBLE_ASSOCIATIONS.each do |association|
      assign_category_for(association) if model_has(association)
    end
  end

  private

  def assign_category_for(association)
    model.categories << Category.find_or_create_by(name: ASSOCIATION_CATEGORY_MAP[association])
  end

  def model_has(association)
    model.try(association) && !model.send(association).empty?
  end
end
