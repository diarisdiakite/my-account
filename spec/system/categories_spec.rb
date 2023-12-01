require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let!(:user) do
    User.create(name: 'Dada', email: 'dada@gmail.com', password: 'my-awesome-password', confirmed_at: Time.current)
  end
  let!(:category) do
    Category.create(user:, name: 'home 1', icon: fixture_file_upload('icon.png', 'image/png'))
  end

  describe 'Categories Get/ index' do
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      get user_categories_path(user_id: user.id)
    end

    it 'returns categories http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders categories index template' do
      expect(response).to render_template(:index)
    end

    it 'response body includes the name field' do
      get user_categories_path(user)
      expect(response.body).to include(category.name)
    end
  end

  describe 'Categories Get/ new' do
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      get new_user_category_path(user_id: user.id)
    end

    it 'returns categories http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders categories new template' do
      expect(response).to render_template(:new)
    end
  end
end
