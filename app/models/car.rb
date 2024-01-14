class Car < ApplicationRecord
    belongs_to :user
    has_many :reservations
    
    validates :name, presence: true, length: { minimum: 2 }
  
    has_one_attached :icon
    validate :validate_icon_presence
  
    def total_reservation_amount
      reservations.any? ? reservations.sum(:total_amount_payable) : 0
    end
  
    private
  
    def validate_icon_presence
      errors.add(:icon, 'Please upload an icon') unless icon.attached?
    end
  end
  