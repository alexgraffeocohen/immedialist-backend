# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    name "The Best Song Ever"
    association :album, strategy: :build

    factory :real_song do
      name "Fake Empire"
      spotify_id "6aUAF8JOd8zEl41B6I18xL"
      duration_ms 207000
      spotify_preview_url "//p.scdn.co/mp3-preview/9bf606134888aa3a0b2c47e19a75d175c3684609"
      spotify_url "https://open.spotify.com/track/6aUAF8JOd8zEl41B6I18xL"
      spotify_popularity 61
    end

    factory :fake_song do
      name "Even The Hipsters Don't Know This Song It's So Obscure"
      spotify_id "ithinkicanithinkicanithinkican"
      duration_ms 207000
      spotify_preview_url "//p.scdn.co/mp3-preview/9bf606134888aa3a0b2c47e19a75d175c3684609"
      spotify_url "https://open.spotify.com/track/6aUAF8JOd8zEl41B6I18xL"
      spotify_popularity 61
    end
  end
end
