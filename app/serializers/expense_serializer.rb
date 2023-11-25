class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount
  has_one :user
end
