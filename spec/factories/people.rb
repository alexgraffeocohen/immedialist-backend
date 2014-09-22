# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "MyString"
    spotify_id "MyString"
    spotify_popularity 1
    spotify_url "MyString"
    date_of_birth "2014-09-21"
    date_of_death "2014-09-21"
  end
end
