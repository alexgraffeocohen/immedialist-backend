class AssignCategoriesToPerson
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

  def self.call(person_model)
    new(person_model).call
  end

  def initialize(person_model)
    @person_model = person_model
  end

  def call
    POSSIBLE_ASSOCIATIONS.each do |association|
      if model_has(association) && model_does_not_already_have_category_for(association)
        assign_category_for(association)
      end
    end
  end

  private

  attr_reader :person_model

  def assign_category_for(association)
    person_model.categories << Category.find_or_create_by(name: ASSOCIATION_CATEGORY_MAP[association])
  end

  def model_has(association)
    person_model.try(association) && !person_model.send(association).empty?
  end

  def model_does_not_already_have_category_for(association)
    !person_model.categories.map(&:name).include?(ASSOCIATION_CATEGORY_MAP[association])
  end
end
