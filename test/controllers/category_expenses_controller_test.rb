require "test_helper"

class CategoryExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_expense = category_expenses(:one)
  end

  test "should get index" do
    get category_expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_category_expense_url
    assert_response :success
  end

  test "should create category_expense" do
    assert_difference("CategoryExpense.count") do
      post category_expenses_url, params: { category_expense: { category_id: @category_expense.category_id, expense_id: @category_expense.expense_id } }
    end

    assert_redirected_to category_expense_url(CategoryExpense.last)
  end

  test "should show category_expense" do
    get category_expense_url(@category_expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_expense_url(@category_expense)
    assert_response :success
  end

  test "should update category_expense" do
    patch category_expense_url(@category_expense), params: { category_expense: { category_id: @category_expense.category_id, expense_id: @category_expense.expense_id } }
    assert_redirected_to category_expense_url(@category_expense)
  end

  test "should destroy category_expense" do
    assert_difference("CategoryExpense.count", -1) do
      delete category_expense_url(@category_expense)
    end

    assert_redirected_to category_expenses_url
  end
end
