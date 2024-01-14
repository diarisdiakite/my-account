class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car
  belongs_to :city
    
  validates :name, presence: true, length: { minimum: 2 }
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :hourly_fee, presence: true, numericality: { greater_than: 1 }
  validates :user_id, presence: true
  validates :city, presence: true
end
