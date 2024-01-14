json.extract! reservation, :id, :user_id, :name, :amount, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
