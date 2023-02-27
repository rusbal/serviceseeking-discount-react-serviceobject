class OrderDiscountCalculator < ActiveInteraction::Base
  MULTIPLIER = 2
  MINIMUM_SUBTOTAL = 10
  DISCOUNT_PERCENT = 0.20
  DISCOUNT_AMOUNT = 2.0

  array :items do
    hash do
      string :sku
      decimal :price
      integer :quantity
    end
  end

  # Task 2. computes and applies the discount (if it reaches a minimum subtotal)
  def execute
    total_meets_minimum_discount       = total_meets_minimum? ? (total * DISCOUNT_PERCENT) : 0.0
    purchase_contains_sku_ccc_discount = purchase_contains_sku_ccc? ? DISCOUNT_AMOUNT : 0.0

    [
      total_meets_minimum_discount,
      purchase_contains_sku_ccc_discount
    ].max
  end

  def total_meets_minimum?
    total >= MINIMUM_SUBTOTAL
  end

  def purchase_contains_sku_ccc?
    items.find { |item| item[:sku] == 'CCC' }.present?
  end

  def total
    items.sum { |item| item[:price] * item[:quantity] }
  end
end
