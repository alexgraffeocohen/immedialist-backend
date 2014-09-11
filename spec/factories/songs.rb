# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    title "MyString"
    duration_ms 1
    spotify_preview_url "MyString"
    spotify_url "MyString"
    spotify_popularity 1
    spotify_id 1
  end
end
