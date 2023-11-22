class CategoryExpenseSerializer < ActiveModel::Serializer
  attributes :id
  has_one :expense
  has_one :category
end
