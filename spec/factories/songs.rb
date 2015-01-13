# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    name "Fake Empire"
    duration_ms 207000
    spotify_preview_url "//p.scdn.co/mp3-preview/9bf606134888aa3a0b2c47e19a75d175c3684609"
    spotify_url "https://open.spotify.com/track/6aUAF8JOd8zEl41B6I18xL"
    spotify_popularity 61
    spotify_id "6aUAF8JOd8zEl41B6I18xL"

    association :album, strategy: :build
  end
end
