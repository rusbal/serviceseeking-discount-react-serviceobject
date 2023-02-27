class OrderDiscountJob < ApplicationJob
  queue_as :default

  def perform(items)
    @items = items
    raise "No item to process" if items.empty?
    process
  end

  private

  def process
    ActiveRecord::Base.transaction do
      create_order.tap do |order|
        @items.each do |item|
          order.order_items.create(
            sku: item[:sku],
            price: item[:price].to_f,
            quantity: item[:quantity].to_i
          )
        end
      end
    end
  end

  def create_order
    Order.create(total: total, discount: discount)
  end

  def total
    @items.sum { |item| item[:price].to_f * item[:quantity].to_i }
  end

  def discount
    @discount ||= OrderDiscountCalculator.run!(items: @items)
  end
end
