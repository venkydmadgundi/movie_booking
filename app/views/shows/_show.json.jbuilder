json.extract! show, :id, :movie_id, :screen_id, :time_slot_id, :show_date, :available_seats, :seat_price, :created_at, :updated_at
json.url show_url(show, format: :json)
