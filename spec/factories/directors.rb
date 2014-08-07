# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :director do
    factory :cuaron do
      name "Alfonso Cuaron"
    end
    factory :nolan do
      name "Christopher Nolan"
    end
  end
end
