class Reservation < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :car, class_name: 'Car', foreign_key: 'car_id'
    belongs_to :city, class_name: 'City', foreign_key: 'city_id'
      
    validates :name, presence: true, length: { minimum: 2 }
    validates :duration, presence: true, numericality: { greater_than: 0 }
    validates :hourly_fee, presence: true, numericality: { greater_than: 1 }
    validates :user_id, presence: true
    validates :city, presence: true
  end
  