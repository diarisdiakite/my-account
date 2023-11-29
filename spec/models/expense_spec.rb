require 'rails_helper'

# frozen_string_literal: true

describe Expense, type: :model do
  let(:author) { User.create(name: 'John') }

  subject do
    Expense.create(
      author: author.id,
      name: 'Hello there',
      amount: 100,
      created_at: '2023-11-23',
      updated_at: '2023-11-23'
    )
  end

  describe 'validations' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if the name is less than 2 characters' do
      subject.name = 'a' * 1
      expect(subject).to_not be_valid
    end

    it 'is not valid if amount is less than 0' do
      subject.amount = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid if amount is not an integer' do
      subject.amount = 'string'
      expect(subject).to_not be_valid
    end
  end
end
