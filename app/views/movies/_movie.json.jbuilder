json.extract! movie, :id, :name, :director_name, :release_date, :active, :created_at, :updated_at
json.url movie_url(movie, format: :json)
