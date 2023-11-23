class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :categories
  has_many :expenses, foreign_key: 'author_id'
  
  before_validation :set_default_recipes_counter

  validates :name, presence: true
  
  # Adding the User::Roles
  # The available roles

  ROLES = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end
end
