# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    name "MyString"
    spotify_id 1
    spotify_popularity 1
    spotify_url "MyString"
  end
end
