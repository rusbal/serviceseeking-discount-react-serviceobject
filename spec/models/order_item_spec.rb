require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  # Associations
  describe "Associations" do
    it { should belong_to(:order) }
  end

  # Validations
  let(:sku) { 'sample-sku-123' }
  let(:price) { 2.0 }
  let(:quantity) { 2 }
  let(:order) do
    Order.new(total: 123.0, discount: 10.0)
  end
  let(:subject) do
    order.order_items.new(
      sku: sku,
      price: price,
      quantity: quantity
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  context "when sku is empty" do
    let(:sku) { '' }
    it { is_expected.to_not be_valid }
  end

  context "when price is zero" do
    let(:price) { 0.0 }
    it { is_expected.to_not be_valid }
  end

  context "when quantity is zero" do
    let(:quantity) { 0.0 }
    it { is_expected.to_not be_valid }
  end
end
