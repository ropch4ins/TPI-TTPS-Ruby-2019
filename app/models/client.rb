class Client < ApplicationRecord
  belongs_to :vat_condition, foreign_key: "vat_condition_id"
  validates_associated :vat_condition
  validates :cuit_cuil, :email, :denomination, presence: true
  #validates :cuit_cuil, :email, uniqueness: true, case_sensitive: true
  validates_uniqueness_of :cuit_cuil, :email, case_sensitive: true
  validates :cuit_cuil, length: {is: 11}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end