# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :genre do
    name 'Amazing Genre'

    factory :movie_genre do
      name 'Action'
    end

    factory :book_genre do
      name 'Western'
    end
  end
end
