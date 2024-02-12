json.extract! reservation, :id, :user_id, :car_id, :city_id, :hourly_fee, :duration, :total_amount_payable,
              :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
