class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :category_expenses, dependent: :destroy
  has_many :categories, through: :category_expenses

  validates :name, presence: true, length: { minimum: 2 }
  validates :amount, presence: true, numericality: { greater_than: 1 }
  validates :author_id, presence: true
end
