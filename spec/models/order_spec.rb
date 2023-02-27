require 'rails_helper'

RSpec.describe Order, type: :model do
  # Associations
  describe "Associations" do
    it { should have_many(:order_items) }
  end

  # Validations
  let(:total) { 10.0 }
  let(:discount) { 2.0 }
  subject { Order.new(total: total, discount: discount) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  context "when total is zero" do
    let(:total) { 0.0 }
    it { is_expected.to_not be_valid }
  end

  context "when discount is zero" do
    let(:discount) { 0.0 }
    it { is_expected.to_not be_valid }
  end
end
