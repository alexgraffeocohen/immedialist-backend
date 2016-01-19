FactoryGirl.define do
  factory :list_item do
    name 'List Item Name'
    association :item, factory: :requested_item, strategy: :build

    trait :with_search do
      association(:search)
    end
  end
end
