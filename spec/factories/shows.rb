# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :show do
    title "MyString"
    creator "MyString"
    episode_length 1
    first_air_date "2014-09-14"
    last_air_date "2014-09-14"
    status "MyString"
    seasons_count 1
    episodes_count 1
    tmdb_id 1
    overview "MyText"
    imdb_id 1
  end
end
