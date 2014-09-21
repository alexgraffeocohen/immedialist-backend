module Helpers
  def category_names_for(model)
    model.categories.map(&:name)
  end
end
