# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    name "The Best Album Ever"

    factory :real_album do
      name "Boxer"
      release_date "2007-05-21"
      album_type "album"
      spotify_id "2pG7mDkQhia2OyGE6fbkmJ"
    end

    factory :fake_album do
      name "This Album Is So Bad Don't Listen To It"
      spotify_id "ithinkicanithinkicanithinkican"
    end
  end
end
