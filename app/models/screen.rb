class Screen < ApplicationRecord
  has_many :shows
  has_many :movies, through: :shows
  validates :name, presence: true
end
