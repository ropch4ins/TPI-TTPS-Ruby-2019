class ReservationDetail < ApplicationRecord
  belongs_to :product, foreign_key: "product_id"
  belongs_to :reservation, foreign_key: "reservation_id"
  validates_associated :product, :reservation
  validates :quantity, :product, :reservation, presence: true
end