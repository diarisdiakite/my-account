class Category < ApplicationRecord
  belongs_to :user
  has_many :category_expenses
  has_many :expenses, through: :category_expenses

  validates :name, presence: true, length: { minimum: 2 }

  has_one_attached :icon
  validate :validate_icon_presence

  def total_expense_amount
    expenses.any? ? expenses.sum(:amount) : 0
  end

  private

  def validate_icon_presence
    errors.add(:icon, 'Please upload an icon') unless icon.attached?
  end
end
