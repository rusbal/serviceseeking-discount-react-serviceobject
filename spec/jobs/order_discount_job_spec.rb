require 'rails_helper'

RSpec.describe OrderDiscountJob, type: :job do
  let(:item_one) do
    { sku: 'sku-100', price: 10.0, quantity: 1 }
  end
  let(:item_two) do
    { sku: 'sku-200', price: 5.0, quantity: 3 }
  end
  let(:items) { [item_one, item_two] }
  subject {
    described_class.perform_now(items)
  }

  it 'creates order' do
    expect { subject }.to change { Order.count }.by(1)
  end

  it 'creates order items' do
    expect { subject }.to change { OrderItem.count }.by(2)
  end
end
