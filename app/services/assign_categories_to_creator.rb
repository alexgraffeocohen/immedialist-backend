class AssignCategoriesToCreator
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

  def self.call(creator_model)
    new(creator_model).call
  end

  def initialize(creator_model)
    @creator_model = creator_model
  end

  def call
    POSSIBLE_ASSOCIATIONS.each do |association|
      if model_has(association) && model_does_not_already_have_category_for(association)
        assign_category_for(association)
      end
    end
  end

  private

  attr_reader :creator_model

  def assign_category_for(association)
    creator_model.categories << Category.find_or_create_by(name: ASSOCIATION_CATEGORY_MAP[association])
  end

  def model_has(association)
    creator_model.try(association) && !creator_model.send(association).empty?
  end

  def model_does_not_already_have_category_for(association)
    !creator_model.categories.map(&:name).include?(ASSOCIATION_CATEGORY_MAP[association])
  end
end
