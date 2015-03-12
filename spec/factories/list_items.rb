FactoryGirl.define do
  factory :list_item do
    name 'List Item Name'
    association :item, factory: :requested_item, strategy: :build
  end
end
