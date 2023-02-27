require 'rails_helper'

RSpec.describe "Orders", type: :request do
  it 'creates an order' do
    post '/orders', params: {
      items: [
        {
          sku: "AAA",
          price: 5.00,
          quantity: 1,
        },
        {
          sku: "BBB",
          price: 8.00,
          quantity: 1
        }
      ]
    }

    expect(response).to have_http_status(:success)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body['message']).to eq 'Job was initiated'
  end

  context 'invalid input' do
    it 'will fail' do
      post '/orders', params: { items: [] }

      expect(response).to have_http_status(422)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['message']).to eq 'No item to process'
    end
  end
end
