class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :categories
  has_many :expenses, foreign_key: 'author_id'

  validates :name, presence: true, length: { minimum: 2 }

  has_one_attached :photo

  # Adding the User::Roles
  # The available roles

  ROLES = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end
end
