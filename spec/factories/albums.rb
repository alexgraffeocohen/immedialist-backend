# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    title "Boxer"
    release_date "2007-05-21"
    album_type "album"
    spotify_id "2pG7mDkQhia2OyGE6fbkmJ"
    spotify_popularity 64
  end
end
