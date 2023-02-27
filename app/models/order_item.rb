class OrderItem < ApplicationRecord
  belongs_to :order

  validates :sku, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
