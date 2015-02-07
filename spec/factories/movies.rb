# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    name "Awesome Movie Name"
    release_date "2030-01-27"
    critics_score 87
    audience_score 85
    critics_consensus "Such an amazing movie, I can't even deal with it."
    poster_link "http://awesomeposter.jpg"
    rating "R"
    rt_link "http://www.rottentomatoes.com/m/awesome_movie_name/"
    tmdb_id 666

    factory :real_movie do
      name "The Matrix"
      release_date "1999-03-30"
      tmdb_id 603
    end

    factory :fake_movie do
      name "There Are No Results For Sure"
      release_date ""
      tmdb_id 90909090
    end
  end
end
