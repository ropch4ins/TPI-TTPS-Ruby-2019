class ItemReservation < ApplicationRecord
  belongs_to :reservation, foreign_key: "reservation_id"
  belongs_to :item, foreign_key: "item_id"
  validates_associated :reservation, :item
  validates :reservation, :item, :date, presence: true
end
