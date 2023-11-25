class CategorySerializer < ActiveModel::Serializer
  attributes :id, :icon
  has_one :user
end
