class TimeSlot < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :name, presence: true
  has_many :shows
end
