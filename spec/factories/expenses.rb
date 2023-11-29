FactoryBot.define do
  factory :expense do
    user { nil }
    name { 'MyString' }
    amount { 1 }
  end
end
