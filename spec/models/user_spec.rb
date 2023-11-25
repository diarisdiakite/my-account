require 'rails_helper'

# frozen_string_literal: true

describe User, type: :model do
  subject { User.create(name: 'Chadid', photo: 'https://unsplash.com/photos/F_-0BxGuVvo111', email: 'bonjour@gmail.com', password: 'my-awesome-pass') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if the name is less than 2 characters' do
      subject.name = 'a' * 1
      expect(subject).to_not be_valid
    end
  end
end
