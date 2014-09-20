# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name "Category"

    factory :film_category do
      name "Film"
    end
  end
end
