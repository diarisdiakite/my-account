FactoryBot.define do
  factory :category_expense do
    association :category
    association :expense
  end
end
