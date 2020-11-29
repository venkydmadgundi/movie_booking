class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  belongs_to :time_slot
  validates :show_date, presence: true
  validates :seat_price, presence: true, numericality: { greater_than: 0 }

  has_many :bookings
  has_many :users, through: :bookings
  validates :bookings, length: { maximum: 100 }

  before_save :validate_booking

  scope :screen_name, -> (name){ where(screen: Screen.find_by(name: name )) }
  default_scope { order("show_date DESC") }

  scope :get_show_date, lambda { |show_date|
    where("show_date = ? ", show_date)
  }

  def seats
    100 - (self.bookings_count || 0)
  end

  def valid_showtime?
    show_time = Time.new(self.show_date.year, self.show_date.month, self.show_date.day,self.time_slot.start_time.utc.strftime("%H"),self.time_slot.start_time.utc.strftime("%M"))
    show_time > Time.now
  end

  def show_dates
    self.map(&:show_date).uniq	  
  end


  private

  def validate_booking
    raise ArgumentError, 'Available seats for the show cannot be more than seats in theatre' if self.available_seats > self.screen.seats
    raise ArgumentError, 'Available seats for the show cannot be less than zero' if self.available_seats < 0   
  end

end
