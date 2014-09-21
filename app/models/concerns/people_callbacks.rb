module PeopleCallbacks
  extend ActiveSupport::Concern

  included do
    after_create :assign_to_person_category
    after_save :assign_associated_categories
  end

  private

  def assign_associated_categories
    CategoryManager.new(self).assign_categories
  end

  def assign_to_person_category
    self.categories << Category.find_or_create_by(name: "Person")
  end
end
