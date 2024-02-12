class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car
  belongs_to :city

  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :hourly_fee, presence: true, numericality: { greater_than: 1 }
  validates :total_amount_payable, presence: true, numericality: { greater_than: 1 }
  validates :user_id, presence: true
  validates :city_id, presence: true
  validates :car_id, presence: true
end
