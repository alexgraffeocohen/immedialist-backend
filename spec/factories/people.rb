# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "Amazing Person"
    spotify_id "MyString"
    spotify_popularity 1
    spotify_url "MyString"
    date_of_birth "2014-09-21"
    date_of_death "2014-09-21"

    factory :real_actor do
      name "Keanu Reeves"
      tmdb_id 6384
    end

    factory :real_actor_with_common_name do
      name "Jennifer"
    end

    factory :fake_actor do
      name "The Worst Actor Ever"
      tmdb_id 90909090
    end

    factory :real_director do
      name "Richard Linklater"
      tmdb_id 564
    end

    factory :director_with_common_name do
      name "Richard"
    end

    factory :fake_director do
      name "The Worst Director Ever"
      tmdb_id 90909090
    end
  end
end
