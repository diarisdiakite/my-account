require 'rails_helper'

# frozen_string_literal: true

describe User, type: :model do
  subject { User.create(name: 'Chadid', photo: 'https://unsplash.com/photos/F_-0BxGuVvo111', bio: 'Student at Microverse.', posts_counter: 10) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if recipes_counter is not an integer' do
      subject.recipes_counter = 'string'
      expect(subject).to_not be_valid
    end

    it 'is not valid if recipes_counter is less than 0' do
      subject.recipes_counter = -1
      expect(subject).to_not be_valid
    end
  end
end
