require 'application_system_test_case'

class CategoryExpensesTest < ApplicationSystemTestCase
  setup do
    @category_expense = category_expenses(:one)
  end

  test 'visiting the index' do
    visit category_expenses_url
    assert_selector 'h1', text: 'Category expenses'
  end

  test 'should create category expense' do
    visit category_expenses_url
    click_on 'New category expense'

    fill_in 'Category', with: @category_expense.category_id
    fill_in 'Expense', with: @category_expense.expense_id
    click_on 'Create Category expense'

    assert_text 'Category expense was successfully created'
    click_on 'Back'
  end

  test 'should update Category expense' do
    visit category_expense_url(@category_expense)
    click_on 'Edit this category expense', match: :first

    fill_in 'Category', with: @category_expense.category_id
    fill_in 'Expense', with: @category_expense.expense_id
    click_on 'Update Category expense'

    assert_text 'Category expense was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Category expense' do
    visit category_expense_url(@category_expense)
    click_on 'Destroy this category expense', match: :first

    assert_text 'Category expense was successfully destroyed'
  end
end
