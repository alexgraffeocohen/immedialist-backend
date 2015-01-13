# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    name "Plainsong"
    release_date "2000-08-22"
    isbn "0375705856"
    cover_link "link_url"
  end
end
