class AddIndexesToCategoriesExpensesAndCategoryExpenses < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :user_id unless index_exists?(:categories, :user_id)
    add_index :expenses, :user_id unless index_exists?(:expenses, :user_id)
    add_index :category_expenses, :category_id unless index_exists?(:category_expenses, :category_id)
    add_index :category_expenses, :expense_id unless index_exists?(:category_expenses, :expense_id)
  end
end
