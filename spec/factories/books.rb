# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "MyString"
    release_date "2014-09-15"
    isbn "MyString"
    cover_link "MyText"
  end
end
