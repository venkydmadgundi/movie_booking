# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user = User.create!(email: 'admin@admin.com', admin: true, password: 'password', password_confirmation: 'password')
slots_price = {12=>100,15=>150,18=>200,21=>250}

days = [Time.now.yesterday.day,Time.now.day,Time.now.tomorrow.day]

movies = Movie.create([ { name: "The Vanishing",director_name:"Kristoffer Nyholm", release_date: Date.today.yesterday, is_active: true}, 
	  { name: "Tanhaji", director_name:"Om Raut", release_date: Date.today - 5.day, is_active: true},
          { name: "Vinashkaal",director_name: "Rakesh Sawant", release_date: Date.today - 8.day, is_active: true},
          { name: "Panga",director_name: "Ashwiny Iyer Tiwari", release_date: Date.today - 9.day, is_active: true},
          { name: "Durgamati",director_name:"G. Askhok", release_date: Date.today - 10.day, is_active: true}])

screens = Screen.create!([{name: 'Screen-A', seats: 50},
		    {name: 'Screen-B', seats: 75},
   	            {name: 'Screen-C', seats: 80}])

def get_show_time(show_hour)
  case show_hour
    when 0..11 then "Morning"
    when 12..15 then "Afternoon"
    when 16..20 then "Evening"
    when 21..23 then "Night"
  end
end

Screen.all.each do |screen|
  index = 0
  slots_price.each do |slot, price|
    index     = 0 if index == 3
    start_at  = Time.new(Time.now.year, Time.now.month, days[index],slot,0)
    end_at    = Time.new(Time.now.year, Time.now.month, days[index],slot+2,0)
    time_slot    = TimeSlot.create({start_time: start_at, end_time: end_at, name: get_show_time(start_at.strftime("%H").to_i)})
    Movie.active.each do |movie|    
      Show.create!(movie: movie, screen: screen, time_slot: time_slot, seat_price: price, show_date:  start_at.strftime("%d-%m-%Y"), available_seats: screen.seats - 1 )
    end
    index += 1
  end
end

