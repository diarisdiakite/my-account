class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :recipes, foreign_key: 'user_id'
  has_many :foods

  before_validation :set_default_recipes_counter

  validates :name, presence: true
  validates :recipes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Adding the User::Roles
  # The available roles

  ROLES = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  # Adding other methods

  def find_recipes_count
    recipes_counter
  end

  private

  def set_default_recipes_counter
    self.recipes_counter ||= 0
  end
end
