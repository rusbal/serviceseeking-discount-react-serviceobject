class OrderDiscountJob < ApplicationJob
  queue_as :default

  def perform(items)
    @items = items
    ActiveRecord::Base.transaction do
      create_order.tap do |order|
        items.each do |item|
          order.order_items.create(
            sku: item[:sku],
            price: item[:price],
            quantity: item[:quantity]
          )
        end
      end
    end
  end

  private

  def create_order
    Order.create(total: total, discount: discount)
  end

  def total
    @items.sum { |item| item[:price] * item[:quantity] }
  end

  def discount
    @discount ||= OrderDiscountCalculator.run!(items: @items)
  end
end
