json.extract! booking, :id, :user_id, :show_id, :seats, :total_price, :status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
