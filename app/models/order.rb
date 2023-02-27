class Order < ApplicationRecord
  has_many :order_items

  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :discount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: :total }
end
