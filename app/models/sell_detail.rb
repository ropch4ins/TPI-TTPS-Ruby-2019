class SellDetail < ApplicationRecord
  belongs_to :product, foreign_key: "product_id"
  belongs_to :sell, foreign_key: "sell_id"
  validates_associated :product, :sell
  has_many :sell_details
  validates :quantity, :product, :sell, presence: true
end
