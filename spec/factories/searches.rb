FactoryGirl.define do
  factory :search do
    name 'user search string'
    association(:list_item)
  end
end
