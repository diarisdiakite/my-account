require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let!(:user) do
    User.create(name: 'Dada', email: 'dada@gmail.com', password: 'my-awesome-password', confirmed_at: Time.current)
  end
  
  let!(:category) do
    Category.create(user_id: user.id, name: 'home 1', icon: fixture_file_upload('icon.png', 'image/png'))
  end
  
  let!(:expense) do
    Expense.create(author_id: user.id, name: 'home 1', amount: 1000, category_expenses: [CategoryExpense.new(category: category)])
  end

  describe 'Expenses Get/ index' do
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      get user_category_expenses_path(user, category)
    end

    it 'returns Expenses http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders Expenses index template' do
      expect(response).to render_template(:index)
    end

    it 'response body includes the name field' do
      expect(response.body).to include(expense.name)
    end
  end

  describe 'Categories Get/ new' do
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      get new_user_category_expense_path(user, category)
    end

    it 'returns categories http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders categories new template' do
      expect(response).to render_template(:new)
    end

    it 'response body includes correct placeholder text' do
      get new_user_category_expense_path(user, category)
      expect(response.body).to include(category.name)
    end
  end
end
