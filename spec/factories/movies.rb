# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "The Matrix"
    release_date "1999-03-31"
    critics_score 87
    audience_score 85
    critics_consensus "An ingenious combination of Hong Kong action, ground-breaking Hollywood FX, and an imaginative vision."
    poster_link "http://content6.flixster.com/movie/11/16/80/1116809..."
    rating "R"
    rt_link "http://www.rottentomatoes.com/m/matrix/"
  end
end
