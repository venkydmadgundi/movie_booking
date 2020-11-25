class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show
  before_save :validate_booking

  default_scope { order("updated_at DESC") }

  def self.create_booking(booking)
    Booking.transaction do
      booking.save!
      booking.show.available_seats -= booking.seats
      booking.show.save!
    end
  end

  def self.update_booking(booking, seats)
    Booking.transaction do
      booking.show.available_seats += booking.seats
      booking.show.available_seats -= seats
      booking.show.save!
      booking.seats = seats
      booking.save!
    end
  end

  def self.delete_booking(booking)
    Booking.transaction do
      booking.show.available_seats += booking.seats
      booking.show.save!
      booking.destroy!
    end
  end

  private

  def validate_booking
    raise ArgumentError, 'Seats for the booking cannot be more than the available seats for the show' if self.seats > self.show.available_seats
    raise ArgumentError, 'Seats for the booking cannot be 0' if self.seats == 0
  end
end
