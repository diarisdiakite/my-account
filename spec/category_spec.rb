require 'rails_helper'

# frozen_string_literal: true

describe Category, type: :model do
  let(:user) { User.create(name: 'John', photo: 'photo_url', bio: 'A bio') }

  subject do
    Category.create(
      user: user.id,
      name: 'First category',
      icon: 'This is an icon',
      created_at: '2023-11-23',
      updated_at: '2023-11-23'
    )
  end

  describe 'validations' do
    it 'is not valid without a title' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if title exceeds 250 characters' do
      subject.name = 'a' * 1
      expect(subject).to_not be_valid
    end

    it 'is not valid if comments_counter is not an integer' do
      subject.icon = 'string'
      expect(subject).to_not be_valid
    end
  end
end
