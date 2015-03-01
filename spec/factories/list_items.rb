FactoryGirl.define do
  factory :list_item do
    name 'List Item Name'
    association :item, factory: :movie, strategy: :build
  end

end
