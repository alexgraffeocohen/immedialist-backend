# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    name "The National"
    spotify_id "2cCUtGK9sDU2EoElnk0GNB"
    spotify_popularity 65
    spotify_url "https://open.spotify.com/artist/2cCUtGK9sDU2EoElnk0GNB"
  end
end
