class Shipping < ApplicationRecord
  validates :receiver_name, presence: true
  validates :receiver_phone, presence: true
  validates :shipping_address, presence: true
  validates :shipping_day, presence: true
end
