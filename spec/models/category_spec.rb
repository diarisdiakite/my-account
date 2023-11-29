require 'rails_helper'

# frozen_string_literal: true

describe Category, type: :model do
  let(:user) { User.create(name: 'John') }

  subject do
    Category.create(
      user: user.id,
      name: 'First category',
      icon: fixture_file_upload('icon.png', 'image/png'),
      created_at: '2023-11-23',
      updated_at: '2023-11-23'
    )
  end

  describe 'validations' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if name is less than 2 characters' do
      subject.name = 'a' * 1
      expect(subject).to_not be_valid
    end
  end
end
