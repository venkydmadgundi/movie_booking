class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :bookings
  has_many :shows, through: :bookings
end
