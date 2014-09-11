# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    title "MyString"
    release_date "2014-09-11"
    album_type "MyString"
    spotify_id 1
    spotify_popularity 1
  end
end
