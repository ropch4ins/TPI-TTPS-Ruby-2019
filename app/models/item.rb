class Item < ApplicationRecord
  enum status: [:disponible, :reservado, :vendido]
  belongs_to :product, foreign_key: "product_id"
  validates :product, presence: true
  validates_associated :product

  def price
    product.price
  end

end
