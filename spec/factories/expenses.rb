FactoryBot.define do
  factory :expense do
    # user { nil }
    name { 'MyString' }
    amount { 1 }
    association :author, factory: :user

    after(:build) do |expense|
      expense.category_expenses << build(:category_expense, category: expense.category)
    end
  end
end
