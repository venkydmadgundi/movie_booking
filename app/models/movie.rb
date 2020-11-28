class Movie < ApplicationRecord
  validates :name, presence: true
  validates :director_name, presence: true
  validates :release_date, presence: true
  validates :is_active, inclusion: [true, false]
  scope :active, -> { where("is_active = true") }
  has_many :shows
  has_many :screens, through: :shows

end
